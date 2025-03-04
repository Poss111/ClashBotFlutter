package main

import (
	"fmt"

	"github.com/pulumi/pulumi-aws/sdk/v6/go/aws/acm"
	"github.com/pulumi/pulumi-aws/sdk/v6/go/aws/cloudfront"
	"github.com/pulumi/pulumi-aws/sdk/v6/go/aws/route53"
	"github.com/pulumi/pulumi-aws/sdk/v6/go/aws/s3"
	"github.com/pulumi/pulumi/sdk/v3/go/pulumi"
	"github.com/pulumi/pulumi/sdk/v3/go/pulumi/config"
)

func main() {
	pulumi.Run(func(ctx *pulumi.Context) error {
		conf := config.New(ctx, "clash-bot")
		domainName := conf.Require("domainName")
		const s3OriginId = "clash-bot-s3-bucket-origin"

		cert, err := acm.LookupCertificate(ctx, &acm.LookupCertificateArgs{
			Domain:   domainName,
			Statuses: []string{"ISSUED"},
		}, nil)
		if err != nil {
			return fmt.Errorf("failed to lookup certificate: %w", err)
		}
		// Create an S3 bucket
		bucket, err := s3.NewBucket(ctx, "clashBotBucket", &s3.BucketArgs{
			Bucket: pulumi.String("clash-bot-ninja-2"),
			Tags: pulumi.StringMap{
				"Environment": pulumi.String("production"),
				"Name":        pulumi.String("clashBotBucket"),
			},
			ForceDestroy: pulumi.Bool(true),
		})
		if err != nil {
			return fmt.Errorf("failed to create S3 bucket: %w", err)
		}

		// Create a CloudFront origin access control (OAC)
		oac, err := cloudfront.NewOriginAccessControl(ctx, "oac", &cloudfront.OriginAccessControlArgs{
			Name:                          pulumi.String("FlutterWebOAC"),
			OriginAccessControlOriginType: pulumi.String("s3"),
			Description:                   pulumi.String("OAC for S3 bucket"),
			SigningBehavior:               pulumi.String("always"),
			SigningProtocol:               pulumi.String("sigv4"),
		})
		if err != nil {
			return fmt.Errorf("failed to create CloudFront origin access control: %w", err)
		}

		// Create a CloudFront distribution
		cloudfrontDis, err := cloudfront.NewDistribution(ctx, "clashBotDistribution", &cloudfront.DistributionArgs{
			Enabled: pulumi.Bool(true),
			Origins: cloudfront.DistributionOriginArray{
				&cloudfront.DistributionOriginArgs{
					DomainName:            bucket.BucketRegionalDomainName,
					OriginId:              pulumi.String(s3OriginId),
					OriginAccessControlId: oac.ID(),
				},
			},
			DefaultRootObject: pulumi.String("index.html"),
			DefaultCacheBehavior: &cloudfront.DistributionDefaultCacheBehaviorArgs{
				TargetOriginId:       pulumi.String(s3OriginId),
				ViewerProtocolPolicy: pulumi.String("redirect-to-https"),
				AllowedMethods: pulumi.StringArray{
					pulumi.String("GET"),
					pulumi.String("HEAD"),
				},
				CachedMethods: pulumi.StringArray{
					pulumi.String("GET"),
					pulumi.String("HEAD"),
				},
				ForwardedValues: &cloudfront.DistributionDefaultCacheBehaviorForwardedValuesArgs{
					QueryString: pulumi.Bool(false),
					Cookies: &cloudfront.DistributionDefaultCacheBehaviorForwardedValuesCookiesArgs{
						Forward: pulumi.String("none"),
					},
				},
				MinTtl:     pulumi.Int(0),
				DefaultTtl: pulumi.Int(3600),
				MaxTtl:     pulumi.Int(86400),
			},
			Restrictions: &cloudfront.DistributionRestrictionsArgs{
				GeoRestriction: &cloudfront.DistributionRestrictionsGeoRestrictionArgs{
					RestrictionType: pulumi.String("whitelist"),
					Locations: pulumi.StringArray{
						pulumi.String("US"),
						pulumi.String("CA"),
						pulumi.String("GB"),
						pulumi.String("DE"),
					},
				},
			},
			ViewerCertificate: &cloudfront.DistributionViewerCertificateArgs{
				AcmCertificateArn:      pulumi.String(cert.Arn),
				SslSupportMethod:       pulumi.String("sni-only"),
				MinimumProtocolVersion: pulumi.String("TLSv1.2_2019"),
			},
			Aliases: pulumi.StringArray{
				pulumi.String(domainName),
			},
		})
		if err != nil {
			return fmt.Errorf("failed to create CloudFront distribution: %w", err)
		}

		hostedZone, err := route53.LookupZone(ctx, &route53.LookupZoneArgs{
			Name: pulumi.StringRef(domainName),
		})
		if err != nil {
			return fmt.Errorf("failed to lookup Route 53 hosted zone: %w", err)
		}

		_, err = route53.NewRecord(ctx, "clashBotNinjaRecord", &route53.RecordArgs{
			Name:   pulumi.String(domainName),
			ZoneId: pulumi.String(hostedZone.ZoneId),
			Type:   pulumi.String("A"),
			Aliases: route53.RecordAliasArray{
				&route53.RecordAliasArgs{
					Name:                 cloudfrontDis.DomainName,
					ZoneId:               cloudfrontDis.HostedZoneId,
					EvaluateTargetHealth: pulumi.Bool(true),
				},
			},
		}, pulumi.Timeouts(&pulumi.CustomTimeouts{
			Create: "30s",
			Update: "30s",
			Delete: "30s",
		}))
		if err != nil {
			return fmt.Errorf("failed to create Route 53 record: %w", err)
		}

		renderedValue := ""

		policy := pulumi.All(cloudfrontDis.Arn, bucket.Arn).ApplyT(func(arns []interface{}) (string, error) {
			renderedValue = fmt.Sprintf(`{
				"Version": "2012-10-17",
				"Statement": [
					{
						"Sid": "AllowCloudFrontServicePrincipal",
						"Effect": "Allow",
						"Principal": {
							"Service":  "cloudfront.amazonaws.com"
						},
						"Action":  "s3:GetObject",
						"Resource": "%s/*",
						"Condition": {
							"StringEquals": {
								"AWS:SourceArn": "%s"
							}
						}
					}
				]
			}`, arns[1], arns[0])
			ctx.Log.Info(fmt.Sprintf("S3 Bucket Policy Document: %s\n", renderedValue), nil)
			return renderedValue, nil
		}).(pulumi.StringOutput)

		// Enable public access for static site hosting (CloudFront will handle security)
		_, err = s3.NewBucketPolicy(ctx, "bucketPolicy", &s3.BucketPolicyArgs{
			Bucket: bucket.ID(),
			Policy: policy,
		})
		if err != nil {
			return fmt.Errorf("failed to create S3 bucket policy: %w %s", err, renderedValue)
		}

		// Export the website URL
		ctx.Export("websiteUrl", cloudfrontDis.DomainName)
		ctx.Export("s3Bucket", bucket.BucketDomainName)

		return nil
	})
}
