locals {
  public_alb            = "gromo-insure-pub-alb-prod-1405054755.ap-south-1.elb.amazonaws.com"
  internal_alb           = "internal-gromo-insure-pvt-alb-prod-559994731.ap-south-1.elb.amazonaws.com"
  nlb                   = "gromo-insure-nlb-hi-prod-bbd30a1f0442501f.elb.ap-south-1.amazonaws.com"
  mi_nlb                = "gromo-insure-nlb-mi-prod-b50cfabfc4bf25d7.elb.ap-south-1.amazonaws.com"
  cloudfront_insure_co_in = "d16li7roijoikn.cloudfront.net"
  cloudfront_statichi   = "d2oz5yeb4pm1gq.cloudfront.net"
  cloudfront_staticmi   = "d3dz3yzx6vuibg.cloudfront.net"
  cloudfront_pos        = "dznu92h4xxaw9.cloudfront.net"
  cloudfront_statictw   = "d21j3me117jtsp.cloudfront.net"
  cloudfront_sales      = "ds5vwu0g3uqmt.cloudfront.net"
  insure_prod_api       = "d-a1q5ym60dk.execute-api.ap-south-1.amazonaws.com"
  motoinsure_prod_api   = "d-pzarljefza.execute-api.ap-south-1.amazonaws.com"
  redis_dns             = "gromo-insure-redis-prod.1fsxp7.clustercfg.aps1.cache.amazonaws.com"
  internal_record_id    = "ZP97RAFLXTNZK" 
  prod_rds              = "insurance-db-prod.cekkspcerzfr.ap-south-1.rds.amazonaws.com"
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
      name    = "hifrontendapi"
      type    = "A"
      alias   = {
       name    = local.internal_alb
       zone_id = local.internal_record_id
      }
     },
      {
       zone_id = var.zone_id
       name    = "hiprequoteapi"
       type    = "A"
       alias   = {
        name    = local.internal_alb
        zone_id = local.internal_record_id
       }
      },
      {
       zone_id = var.zone_id
       name    = "hinivaapi"
       type    = "A"
       alias   = {
        name    = local.internal_alb
        zone_id = local.internal_record_id
        }
       },
       {
        zone_id = var.zone_id
        name    = "hicareapi"
        type    = "A"
        alias   = {
         name    = local.internal_alb
         zone_id = local.internal_record_id
        }
       },
       {
        zone_id = var.zone_id
        name    = "hihdfcapi"
        type    = "A"
        alias   = {
         name    = local.internal_alb
         zone_id = local.internal_record_id
        }
       },
       {
        zone_id = var.zone_id
        name    = "hirelianceapi"
        type    = "A"
        alias   = {
         name    = local.internal_alb
         zone_id = local.internal_record_id
        }
       },
       {
        zone_id = var.zone_id
        name    = "hizunoapi"
        type    = "A"
        alias   = {
         name    = local.internal_alb
         zone_id = local.internal_record_id
        }
       },
       {
        zone_id = var.zone_id
        name    = "hi"
        type    = "A"
        alias   = {
         name    = local.public_alb
         zone_id = local.internal_record_id
        }
       },
       {
        zone_id = var.zone_id
        name    = "miagpconnectapi"
        type    = "A"
        alias   = {
         name    = local.public_alb
         zone_id = local.internal_record_id
          }
        },
        {
         zone_id = var.zone_id
         name    = "miagconnectapi"
         type    = "A"
         alias   = {
          name    = local.internal_alb
          zone_id = local.internal_record_id
         }
        },
        {
         zone_id = var.zone_id
         name    = "offlineapi"
         type    = "A"
         alias   = {
          name    = local.internal_alb
          zone_id = local.internal_record_id
         }
        },
        {
         zone_id = var.zone_id
         name    = "oiflapi"
         type    = "A"
         alias   = {
          name    = local.internal_alb
          zone_id = local.internal_record_id
         }
        },
         {
          zone_id = var.zone_id
          name    = "mioffline"
          type    = "A"
          alias   = {
           name    = local.public_alb
           zone_id = local.internal_record_id
           }
          },
          {
           zone_id = var.zone_id
           name    = "partner"
           type    = "A"
           alias   = {
            name    = local.public_alb
            zone_id = local.internal_record_id
            }
           },
           {
            zone_id = var.zone_id
            name    = "authapi"
            type    = "A"
            alias   = {
            name    = local.public_alb
            zone_id = local.internal_record_id
            }
            },
            {
             zone_id = var.zone_id
             name    = "kyc"
             type    = "A"
             alias   = {
              name    = local.public_alb
              zone_id = local.internal_record_id
              }
             },
             {
              zone_id = var.zone_id
              name    = "insuranceapi"
              type    = "A"
              alias   = {
               name    = local.public_alb
               zone_id = local.internal_record_id
               }
              },
              {
               zone_id = var.zone_id
               name    = "crm"
               type    = "A"
               alias   = {
                name    = local.public_alb
                zone_id = local.internal_record_id
                }
               },
               {
                zone_id = var.zone_id
                name    = "mi"
                type    = "A"
                alias   = {
                name    = local.public_alb
                zone_id = local.internal_record_id
                }
               },
               {
                zone_id = var.zone_id
                name    = "api"
                type    = "A"
                alias   = {
                 name    = local.public_alb
                 zone_id = local.internal_record_id
                 }
                },
                {
                 zone_id = var.zone_id
                 name    = "tw"
                 type    = "A"
                 alias   = {
                  name    = local.public_alb
                  zone_id = local.internal_record_id
                  }
                 },
                 {
                  zone_id = var.zone_id
                  name    = "recon"
                  type    = "A"
                  alias   = {
                   name    = local.public_alb
                   zone_id = local.internal_record_id
                   }
                  },
                {
                  zone_id = var.zone_id
                  name    = "mimasterdataapi"
                  type    = "A"
                  alias   = {
                   name    = local.internal_alb
                   zone_id = local.internal_record_id
                   }
                  },
                {
                  zone_id = var.zone_id
                  name    = "mircapi"
                  type    = "A"
                  alias   = {
                   name    = local.internal_alb
                   zone_id = local.internal_record_id
                   }
                  },
                {
                  zone_id = var.zone_id
                  name    = "miposapi"
                  type    = "A"
                  alias   = {
                   name    = local.internal_alb
                   zone_id = local.internal_record_id
                   }
                  },
                {
                  zone_id = var.zone_id
                  name    = "miquotationapi"
                  type    = "A"
                  alias   = {
                   name    = local.internal_alb
                   zone_id = local.internal_record_id
                   }
                  },
                {
                  zone_id = var.zone_id
                  name    = "miproposalapi"
                  type    = "A"
                  alias   = {
                   name    = local.internal_alb
                   zone_id = local.internal_record_id
                   }
                  },
                {
                  zone_id = var.zone_id
                  name    = "mikycapi"
                  type    = "A"
                  alias   = {
                   name    = local.internal_alb
                   zone_id = local.internal_record_id
                   }
                  },
                {
                  zone_id = var.zone_id
                  name    = "mipaymentapi"
                  type    = "A"
                  alias   = {
                   name    = local.internal_alb
                   zone_id = local.internal_record_id
                   }
                  },
                {
                  zone_id = var.zone_id
                  name    = "otp"
                  type    = "A"
                  alias   = {
                   name    = local.internal_alb
                   zone_id = local.internal_record_id
                   }
                  },
                {
                  zone_id = var.zone_id
                  name    = "mileadapi"
                  type    = "A"
                  alias   = {
                   name    = local.internal_alb
                   zone_id = local.internal_record_id
                   }
                  },
                {
                  zone_id = var.zone_id
                  name    = "twapi"
                  type    = "A"
                  alias   = {
                   name    = local.internal_alb
                   zone_id = local.internal_record_id
                   }
                  },
                {
                  zone_id = var.zone_id
                  name    = "twquotationapi"
                  type    = "A"
                  alias   = {
                   name    = local.internal_alb
                   zone_id = local.internal_record_id
                   }
                  },
                {
                  zone_id = var.zone_id
                  name    = "twproposalapi"
                  type    = "A"
                  alias   = {
                   name    = local.internal_alb
                   zone_id = local.internal_record_id
                   }
                  },
                {
                  zone_id = var.zone_id
                  name    = "twpaymentapi"
                  type    = "A"
                  alias   = {
                   name    = local.internal_alb
                   zone_id = local.internal_record_id
                   }
                  },
                {
                  zone_id = var.zone_id
                  name    = "twmasterdataapi"
                  type    = "A"
                  alias   = {
                   name    = local.internal_alb
                   zone_id = local.internal_record_id
                   }
                  },
                {
                 zone_id = var.zone_id
                 name    = "proxy-prod"
                 type    = "A"
                 alias   = {
                  name    = local.nlb
                  zone_id = "ZVDDRBQ08TROA"
                  }
                 },
                 {
                 zone_id = var.zone_id
                 name    = "mifourwheelerapi"
                 type    = "A"
                 alias   = {
                  name    = local.mi_nlb
                  zone_id = "ZVDDRBQ08TROA"
                  }
                 },
                {
                  zone_id = var.zone_id
                  name    = "insure-prod-rds"
                  type    = "CNAME"
                  ttl    = 5
                  records = [local.prod_rds]
                },
      #  {
      #   zone_id = var.zone_id
      #   name    = "insure-prod-mongo-lead"
      #   type    = "CNAME"
      #   ttl    = 5
      #   records = [local.prod_mongo]
      #  },
      #  {
      #   zone_id = var.zone_id
      #   name    = "insure-prod-mongo-pos"
      #   type    = "CNAME"
      #   ttl    = 5
      #   records = [local.prod_mongo_pos]
      #  },
       {
        zone_id = var.zone_id
        name    = "insurance-redis-prod"
        type    = "CNAME"
        ttl    = 5
        records = [local.redis_dns]
       },
       {
        zone_id = var.zone_id
        name    = "api-prod"
        type    = "A"
        alias   = {
        name    = local.insure_prod_api
        zone_id = "Z3VO1THU9YC4UR"
        }
        },
        {
        zone_id = var.zone_id
        name    = "miapi"
        type    = "A"
        alias   = {
        name    = local.motoinsure_prod_api
        zone_id = "Z3VO1THU9YC4UR"
         }
        },
        {
         zone_id = var.zone_id
         name    = "www"
         type    = "CNAME"
         ttl    = 5
         records = [local.cloudfront_insure_co_in]
         },
         {
         zone_id = var.zone_id
         name    = "staticmi"
         type    = "CNAME"
         ttl    = 5
         records = [local.cloudfront_staticmi]
         },
         {
         zone_id = var.zone_id
         name    = "pos"
         type    = "CNAME"
         ttl    = 5
         records = [local.cloudfront_pos]
         },
         {
         zone_id = var.zone_id
         name    = "statictw"
         type    = "CNAME"
         ttl    = 5
         records = [local.cloudfront_statictw]
         },
         {
         zone_id = var.zone_id
         name    = "sales"
         type    = "CNAME"
         ttl    = 5
         records = [local.cloudfront_sales]
         },
        {
         zone_id = var.zone_id
         name    = "statichi"
         type    = "CNAME"
         ttl    = 5
         records = [local.cloudfront_statichi]
         }

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