locals {
   public_alb            = "gromo-insure-pub-alb-stg-1994656997.ap-south-1.elb.amazonaws.com"
   internal_alb           = "internal-gromo-insure-pvt-alb-stg-1282258256.ap-south-1.elb.amazonaws.com"
   nlb                   = "gromo-insure-nlb-stg-9efe3591cc03b3a8.elb.ap-south-1.amazonaws.com"
   api-gateway           = "d-8p68l7c5zl.execute-api.ap-south-1.amazonaws.com."
  #mi_nlb                = "gromo-insure-nlb-mi-prod-b50cfabfc4bf25d7.elb.ap-south-1.amazonaws.com"
  # cloudfront_insure_co_in = "d16li7roijoikn.cloudfront.net"
  cloudfront_statichi   = "ddkzoi5d7mepq.cloudfront.net"
  cloudfront_staticmi   = "d3l7mqbrohx6.cloudfront.net"
  cloudfront_pos        = "d2svg5odtfdygn.cloudfront.net"
   cloudfront_statictw   = "d2l0o9xrjnmknn.cloudfront.net"
   cloudfront_sales     = "d46f1xhba95cb.cloudfront.net"
  # insure_prod_api       = "d-a1q5ym60dk.execute-api.ap-south-1.amazonaws.com"
  # motoinsure_prod_api   = "d-pzarljefza.execute-api.ap-south-1.amazonaws.com"
  # redis_dns             = "gromo-insure-redis-prod.1fsxp7.clustercfg.aps1.cache.amazonaws.com"
  internal_record_id    = "ZP97RAFLXTNZK"
  internal_record_nlb    = "ZVDDRBQ08TROA"
  internal_record_api     = "Z3VO1THU9YC4UR"
  # prod_rds              = "insurance-db-prod.cekkspcerzfr.ap-south-1.rds.amazonaws.com"
  # prod_mongo            = "insurance-prod-test.62xg5.mongodb.net"
  # prod_mongo_pos        = "pos-production-test.62xg5.mongodb.net"
}


module "records" {
  source  = "../../../../../../modules/route53/records"
  #version = "~> 2.0"
  zone_name = var.zone_name

  records = [
     {
      zone_id = var.zone_id
      name    = "twstaging"
      type    = "A"
      alias   = {
       name    = local.public_alb 
       zone_id = local.internal_record_id
      }
     },
    {
      zone_id = var.zone_id
      name    = "insuranceapi-stg"
      type    = "A"
      alias   = {
      name    = local.internal_alb 
      zone_id = local.internal_record_id
      }
    },
    {
      zone_id = var.zone_id
      name    = "agpconnectstagingapi"
      type    = "A"
      alias   = {
      name    = local.public_alb 
      zone_id = local.internal_record_id
      }
      },
      {
      zone_id = var.zone_id
      name    = "histaging"
      type    = "A"
      alias   = {
        name    = local.public_alb
        zone_id = local.internal_record_id
      }
      },
      {
      zone_id = var.zone_id
      name    = "twstagingapi"
      type    = "A"
      alias   = {
        name    = local.public_alb
        zone_id = local.internal_record_id
      }
      },
      {
      zone_id = var.zone_id
      name    = "miofflinestaging"
      type    = "A"
      alias   = {
        name    = local.public_alb
        zone_id = local.internal_record_id
      }
      },
      {
      zone_id = var.zone_id
      name    = "partnerstaging"
      type    = "A"
      alias   = {
        name    = local.public_alb
        zone_id = local.internal_record_id
      }
      },
      # {
      #   zone_id = var.zone_id
      #   name    = "pos-stg"
      #   type    = "A"
      #   alias   = {
      #     name    = local.public_alb
      #     zone_id = local.internal_record_id
      #   }
      # },
      # {
      #   zone_id = var.zone_id
      #   name    = "api-stg"
      #   type    = "A"
      #   alias   = {
      #     name    = local.public_alb
      #     zone_id = local.internal_record_id
      #   }
      # },
      {
        zone_id = var.zone_id
        name    = "stagingkyc"
        type    = "A"
        alias   = {
          name    = local.public_alb
          zone_id = local.internal_record_id
        }
      },
      {
        zone_id = var.zone_id
        name    = "motor-stg"
        type    = "A"
        alias   = {
          name    = local.public_alb
          zone_id = local.internal_record_id
        }
      },
      {
      zone_id = var.zone_id
      name    = "mileadstagingapi"
      type    = "A"
      alias   = {
        name    = local.internal_alb 
        zone_id = local.internal_record_id
      }
      },
      {
      zone_id = var.zone_id
      name    = "mikycstagingapi"
      type    = "A"
      alias   = {
        name    = local.internal_alb
        zone_id = local.internal_record_id
        }
      },
      {
        zone_id = var.zone_id
        name    = "posstagingapi"
        type    = "A"
        alias   = {
          name    = local.internal_alb
          zone_id = local.internal_record_id
        }
      },
      {
        zone_id = var.zone_id
        name    = "mircstagingapi"
        type    = "A"
        alias   = {
          name    = local.internal_alb
          zone_id = local.internal_record_id
        }
      },
      {
        zone_id = var.zone_id
        name    = "mimasterstagingapi"
        type    = "A"
        alias   = {
          name    = local.internal_alb
          zone_id = local.internal_record_id
        }
      },
      {
      zone_id = var.zone_id
      name    = "otpstaging"
      type    = "A"
      alias   = {
        name    = local.internal_alb
        zone_id = local.internal_record_id
        }
      },
      {
        zone_id = var.zone_id
        name    = "twpaymentstagingapi"
        type    = "A"
        alias   = {
          name    = local.internal_alb
          zone_id = local.internal_record_id
        }
      },
      {
        zone_id = var.zone_id
        name    = "twproposalstagingapi"
        type    = "A"
        alias   = {
          name    = local.internal_alb
          zone_id = local.internal_record_id
        }
      },
      {
        zone_id = var.zone_id
        name    = "twquotationstagingapi"
        type    = "A"
        alias   = {
          name    = local.internal_alb
          zone_id = local.internal_record_id
        }
      },
      {
        zone_id = var.zone_id
        name    = "htmltopdfconverter"
        type    = "A"
        alias   = {
          name    = local.internal_alb
          zone_id = local.internal_record_id
        }
      },
      {
        zone_id = var.zone_id
        name    = "agconnectstagingapi"
        type    = "A"
        alias   = {
          name    = local.internal_alb
          zone_id = local.internal_record_id
        }
      },
      {
        zone_id = var.zone_id
        name    = "hizunostagingapi"
        type    = "A"
        alias   = {
          name    = local.internal_alb
          zone_id = local.internal_record_id
        }
      },
      {
      zone_id = var.zone_id
      name    = "hihdfcstagingapi"
      type    = "A"
      alias   = {
        name    = local.internal_alb
        zone_id = local.internal_record_id
        }
      },
      {
        zone_id = var.zone_id
        name    = "hicarestagingapi"
        type    = "A"
        alias   = {
          name    = local.internal_alb
          zone_id = local.internal_record_id
        }
      },
      {
      zone_id = var.zone_id
      name    = "hireliancestagingapi"
      type    = "A"
      alias   = {
        name    = local.internal_alb
        zone_id = local.internal_record_id
        }
      },
      {
      zone_id = var.zone_id
      name    = "hinivastagingapi"
      type    = "A"
      alias   = {
        name    = local.internal_alb
        zone_id = local.internal_record_id
        }
      },
      {
      zone_id = var.zone_id
      name    = "hiprequotestagingapi"
      type    = "A"
      alias   = {
        name    = local.internal_alb
        zone_id = local.internal_record_id
        }
      },
      {
      zone_id = var.zone_id
      name    = "hifrontendstagingapi"
      type    = "A"
      alias   = {
        name    = local.internal_alb
        zone_id = local.internal_record_id
        }
      },
      {
      zone_id = var.zone_id
      name    = "offlinestagingapi"
      type    = "A"
      alias   = {
        name    = local.internal_alb
        zone_id = local.internal_record_id
        }
      },
      {
      zone_id = var.zone_id
      name    = "oiflstagingapi"
      type    = "A"
      alias   = {
        name    = local.internal_alb
        zone_id = local.internal_record_id
        }
      },
      {
      zone_id = var.zone_id
      name    = "crm-stg"
      type    = "A"
      alias   = {
        name    = local.internal_alb
        zone_id = local.internal_record_id
        }
      },
      # {
      # zone_id = var.zone_id
      # name    = "mimasterstagingapi"
      # type    = "A"
      # alias   = {
      #   name    = local.internal_alb
      #   zone_id = local.internal_record_id
      #   }
      # },
      # {
      # zone_id = var.zone_id
      # name    = "mircstagingapi"
      # type    = "A"
      # alias   = {
      #   name    = local.internal_alb
      #   zone_id = local.internal_record_id
      #   }
      # },
      {
      zone_id = var.zone_id
      name    = "mv-stg"
      type    = "A"
      alias   = {
        name    = local.internal_alb
        zone_id = local.internal_record_id
        }
      },
      {
      zone_id = var.zone_id
      name    = "motor-lead-api-stg"
      type    = "A"
      alias   = {
        name    = local.internal_alb
        zone_id = local.internal_record_id
        }
      },
      {
      zone_id = var.zone_id
      name    = "fw-quotation-api-stg"
      type    = "A"
      alias   = {
        name    = local.internal_alb
        zone_id = local.internal_record_id
        }
      },
      # {
      # zone_id = var.zone_id
      # name    = "mikycstagingapi"
      # type    = "A"
      # alias   = {
      #   name    = local.internal_alb
      #   zone_id = local.internal_record_id
      #   }
      # },
      {
      zone_id = var.zone_id
      name    = "fw-proposal-api-stg"
      type    = "A"
      alias   = {
        name    = local.internal_alb
        zone_id = local.internal_record_id
        }
      },
      {
      zone_id = var.zone_id
      name    = "fw-payment-api-stg"
      type    = "A"
      alias   = {
        name    = local.internal_alb
        zone_id = local.internal_record_id
        }
      },
      # {
      # zone_id = var.zone_id
      # name    = "otpstaging"
      # type    = "A"
      # alias   = {
      #   name    = local.internal_alb
      #   zone_id = local.internal_record_id
      #   }
      # },
      # {
      # zone_id = var.zone_id
      # name    = "posstagingapi"
      # type    = "A"
      # alias   = {
      #   name    = local.internal_alb
      #   zone_id = local.internal_record_id
      #   }
      # },
      {
        zone_id = var.zone_id
        name    = "api-stg"
        type    = "A"
        alias   = {
        name    = local.api-gateway 
        zone_id = local.internal_record_api
        }
      },
      {
        zone_id = var.zone_id
        name    = "staticmi-stg"
        type    = "CNAME"
        ttl    = 5
        records = [local.cloudfront_staticmi]
      },
      {
        zone_id = var.zone_id
        name    = "pos-stg"
        type    = "CNAME"
        ttl    = 5
        records = [local.cloudfront_pos]
        },
      {
        zone_id = var.zone_id
        name    = "statictw-stg"
        type    = "CNAME"
        ttl    = 5
        records = [local.cloudfront_statictw]
      },
      {
        zone_id = var.zone_id
        name    = "sales-stg"
        type    = "CNAME"
        ttl    = 5
        records = [local.cloudfront_sales]
      },
      {
        zone_id = var.zone_id
        name    = "statichi-stg"
        type    = "CNAME"
        ttl    = 5
        records = [local.cloudfront_statichi]
      },
      {
        zone_id = var.zone_id
        name    = "proxy-stg"
        type    = "A"
        alias   = {
        name    = local.nlb 
        zone_id = local.internal_record_nlb
        }
      },
#     {
#       name    = "ec2"
#       type    = "A"
#       ttl     = 3600
#       records = [
#         "10.10.10.10",
#       ]
#     },
  ]
  #depends_on = [module.zones]
}
