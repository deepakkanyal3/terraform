
# locals {

#  group_types = ["ro", "rw", "admin", "data"]

#  permission_map = {
#     ro = "ViewOnlyAccess"
#     rw = "custom_access"
#     admin = "admin_access"
#     data = "custom_access"
#   }

#  group_combinations = [
#     for account_id in var.account_ids : [
#       for group_type in local.group_types : {
#         group_name        = "${account_id}_${group_type}"
#         group_description = "${group_type} IAM Identity Center Group for Account ${account_id}"
#       }
#     ]
#  ]

#  groups = {
#     for combo in flatten(local.group_combinations) : 
#     combo.group_name => combo
#   }

#  group_names = [
#     for account_id in var.account_ids : [
#       for group_type in local.group_types : "${account_id}_${group_type}"
#     ]
#   ]

#  flattened_group_names = flatten(local.group_names)

#   group_ids = {
#     for g in aws_identitystore_group.sso_groups : g.display_name => g.group_id
#   }

#  assignments = [
#     for account_id in var.account_ids : [
#       for group_type in local.group_types : {
#         account_id       = account_id
#         principal_name   = "${account_id}_${group_type}"
#         permission_set   = lookup(local.permission_map, group_type)
#       }
#     ]
#   ]
# }

locals {
  group_types = ["ro", "rw", "admin"]

  permission_map = {
    ro    = "ViewOnlyAccess"
    rw    = "custom_access"
    admin = "admin_access"
  }

  group_combinations = [
    for account_id in var.account_ids : [
      for group_type in local.group_types : {
        account_name      = var.account_names[account_id]
        group_name        = "${var.account_names[account_id]}_${group_type}"
        group_description = "${group_type} IAM Identity Center Group for Account ${account_id}"
      }
    ]
  ]

  groups = {
    for combo in flatten(local.group_combinations) : 
    combo.group_name => combo
  }

  group_names = [
    for account_id in var.account_ids : [
      for group_type in local.group_types : {
        group_name = "${var.account_names[account_id]}_${group_type}"
      }
    ]
  ]

  flattened_group_names = flatten([for account_id in var.account_ids : [
    for group_type in local.group_types : "${var.account_names[account_id]}_${group_type}"
  ]])

  group_ids = {
    for g in aws_identitystore_group.sso_groups : g.display_name => g.group_id
  }

  assignments = [
    for account_id in var.account_ids : [
      for group_type in local.group_types : {
        account_id       = account_id
        principal_name   = "${var.account_names[account_id]}_${group_type}"
        permission_set   = lookup(local.permission_map, group_type, "default_permission_set")
      }
    ]
  ]

}




# - IAM Identity Center Dynamic Group Creation -

resource "aws_identitystore_group" "sso_groups" {
  for_each = local.groups

  identity_store_id = local.sso_instance_id

  display_name = each.value.group_name
  description  = each.value.group_description
}


# - IAM Identity Center Dynamic User Creation -
# resource "aws_identitystore_user" "sso_users" {
#   for_each          = var.sso_users == null ? {} : var.sso_users
#   identity_store_id = local.sso_instance_id

#   # -- PROFILE DETAILS --
#   # - Primary Information -
#   // The default is the provided given name and family name.
#   # display_name = lookup(each.value, "display_name", join(" ", [each.value.given_name, each.value.family_name]))
#   display_name = each.value.display_name != null ? each.value.display_name : join(" ", [each.value.given_name, each.value.family_name])

#   //(Required, Forces new resource) A unique string used to identify the user. This value can consist of letters, accented characters, symbols, numbers, and punctuation. This value is specified at the time the user is created and stored as an attribute of the user object in the identity store. The limit is 128 characters
#   user_name = each.value.user_name

#   //(Required) Details about the user's full name. Detailed below
#   name {
#     // (Required) First name
#     given_name = each.value.given_name
#     // (Optional) Middle name
#     // Default value is null.
#     middle_name = each.value.middle_name
#     // (Required) Last name
#     family_name = each.value.family_name
#     // (Optional) The name that is typically displayed when the name is shown for display.
#     // Default value is the provided given name and family name.
#     formatted = each.value.name_formatted != null ? each.value.name_formatted : join(" ", [each.value.given_name, each.value.family_name])
#     // (Optional) The honorific prefix of the user.
#     // Default value is null.
#     honorific_prefix = each.value.honorific_prefix
#     // (Optional) The honorific suffix of the user
#     // Default value is null.
#     honorific_suffix = each.value.honorific_suffix
#   }

#   // (Optional) Details about the user's email. At most 1 email is allowed. Detailed below.
#   // Required for this module to ensure users have an email on file for resetting password and receiving OTP.
#   emails {
#     // (Optional) The email address. This value must be unique across the identity store.
#     // Required for this module as explained above.
#     value = each.value.email
#     //(Optional) When true, this is the primary email associated with the user.
#     // Default value is true.
#     primary = each.value.is_primary_email
#     // (Optional) The type of email.
#     // Default value is null.
#     type = each.value.email_type
#   }

#   //(Optional) Details about the user's phone number. At most 1 phone number is allowed. Detailed below.
#   phone_numbers {
#     //(Optional) The user's phone number.
#     // Default value is null.
#     value = each.value.phone_number
#     // (Optional) When true, this is the primary phone number associated with the user.
#     // Default value is true.
#     primary = each.value.is_primary_phone_number
#     // (Optional) The type of phone number.
#     // // Default value is null.
#     type = each.value.phone_number_type
#   }

#   // (Optional) Details about the user's address. At most 1 address is allowed. Detailed below.
#   addresses {
#     // (Optional) The country that this address is in.
#     // Default value is null.
#     country = each.value.country
#     // (Optional) The address locality. You can use this for City/Town/Village
#     // Default value is null.
#     locality = each.value.locality
#     //(Optional) The name that is typically displayed when the address is shown for display.
#     // Default value is the provided street address, locality, region, postal code, and country.
#     formatted = each.value.address_formatted != null ? each.value.address_formatted : join(" ", [lookup(each.value, "street_address", ""), lookup(each.value, "locality", ""), lookup(each.value, "region", ""), lookup(each.value, "postal_code", ""), lookup(each.value, "country", "")])
#     // Default value is null.
#     postal_code = each.value.postal_code
#     // (Optional) When true, this is the primary address associated with the user.
#     // Default value is null.
#     primary = each.value.is_primary_address
#     // (Optional) The region of the address. You can use this for State/Parish/Province.
#     // Default value is true.
#     region = each.value.region
#     // (Optional) The street of the address.
#     // Default value is null.
#     street_address = each.value.street_address
#     // (Optional) The type of address.
#     // Default value is null.
#     type = each.value.address_type
#   }

#   # -- Additional information --
#   // (Optional) The user type.
#   // Default value is null.
#   user_type = each.value.user_type
#   // (Optional) The user's title. Ex. Developer, Principal Architect, Account Manager, etc.
#   // Default value is null.
#   title = each.value.title
#   // (Optional) The user's geographical region or location. Ex. US-East, EU-West, etc.
#   // Default value is null.
#   locale = each.value.locale
#   // (Optional) An alternate name for the user.
#   // Default value is null.
#   nickname = each.value.nickname
#   // (Optional) The preferred language of the user.
#   // Default value is null.
#   preferred_language = each.value.preferred_language
#   // (Optional) An URL that may be associated with the user.
#   // Default value is null.
#   profile_url = each.value.profile_url
#   // (Optional) The user's time zone.
#   // Default value is null.
#   # timezone = each.value.timezone
#   timezone = each.value.timezone

#   # ** IMPORTANT - NOT CURRENTLY SUPPORTED - Will add support when Terraform resource is updated. **
#   # employee_number = lookup(each.value, "employee_number", null)
#   # cost_center = lookup(each.value, "cost_center", null)
#   # organization = lookup(each.value, "organization", null)
#   # division = lookup(each.value, "division", null)
#   # department = lookup(each.value, "department", null)
#   # manager = lookup(each.value, "manager", null)

# }

resource "aws_identitystore_user" "sso_users" {
  for_each          = var.sso_users != null ? var.sso_users : {}
  identity_store_id = local.sso_instance_id

  # Profile Details
  display_name = each.value.display_name != null ? each.value.display_name : join(" ", [each.value.given_name, each.value.family_name])
  user_name    = each.value.user_name

  name {
    given_name       = each.value.given_name
    middle_name      = each.value.middle_name
    family_name      = each.value.family_name
    formatted        = each.value.name_formatted != null ? each.value.name_formatted : join(" ", [each.value.given_name, each.value.family_name])
    honorific_prefix = each.value.honorific_prefix
    honorific_suffix = each.value.honorific_suffix
  }

  emails {
    value    = each.value.email
    primary  = each.value.is_primary_email != null ? each.value.is_primary_email : true
    type     = each.value.email_type
  }

  phone_numbers {
    value    = each.value.phone_number
    primary  = each.value.is_primary_phone_number != null ? each.value.is_primary_phone_number : true
    type     = each.value.phone_number_type
  }

  addresses {
    country          = each.value.country
    locality         = each.value.locality
    formatted        = each.value.address_formatted != null ? each.value.address_formatted : join(" ", [each.value.street_address, each.value.locality, each.value.region, each.value.postal_code, each.value.country])
    postal_code      = each.value.postal_code
    primary          = each.value.is_primary_address
    region           = each.value.region
    street_address   = each.value.street_address
    type             = each.value.address_type
  }

  # Additional Information
  user_type            = each.value.user_type
  title                = each.value.title
  locale               = each.value.locale
  nickname             = each.value.nickname
  preferred_language   = each.value.preferred_language
  profile_url          = each.value.profile_url
  timezone             = each.value.timezone

  # Note: Employee and other fields not supported currently
  # employee_number = lookup(each.value, "employee_number", null)
  # cost_center = lookup(each.value, "cost_center", null)
  # organization = lookup(each.value, "organization", null)
  # division = lookup(each.value, "division", null)
  # department = lookup(each.value, "department", null)
  # manager = lookup(each.value, "manager", null)
}

# resource "aws_identitystore_group_membership" "sso_group_membership" {
#   for_each          = var.sso_users != null ? var.sso_users : {}
#   identity_store_id = local.sso_instance_id

#   group_id  = data.aws_identitystore_group.existing_sso_groups[each.value.group_name].group_id
#   member_id = aws_identitystore_user.sso_users[each.value.user_name].user_id

# }




# - SSO Permission Set -
resource "aws_ssoadmin_permission_set" "pset" {
  for_each = var.permission_sets
  name     = each.key

  # lookup function retrieves the value of a single element from a map, when provided it's key.
  # if the given key does not exist, the default value (null) is returned instead

  instance_arn     = local.ssoadmin_instance_arn
  description      = lookup(each.value, "description", null)
  relay_state      = lookup(each.value, "relay_state", null)      // (Optional) URL used to redirect users within the application during the federation authentication process
  session_duration = lookup(each.value, "session_duration", null) // The length of time that the application user sessions are valid in the ISO-8601 standard
  tags             = lookup(each.value, "tags", {})
}


# - AWS Managed Policy Attachment -
resource "aws_ssoadmin_managed_policy_attachment" "pset_aws_managed_policy" {
  # iterate over the permission_sets map of maps, and set the result to be pset_name and pset_index
  # ONLY if the policy for each pset_index is valid.
  for_each = { for pset in local.pset_aws_managed_policy_maps : "${pset.pset_name}.${pset.policy_arn}" => pset }

  instance_arn       = local.ssoadmin_instance_arn
  managed_policy_arn = each.value.policy_arn
  permission_set_arn = aws_ssoadmin_permission_set.pset[each.value.pset_name].arn

  depends_on = [aws_ssoadmin_account_assignment.account_assignment]
}


# - Customer Managed Policy Attachment -
resource "aws_ssoadmin_customer_managed_policy_attachment" "pset_customer_managed_policy" {
  for_each = { for pset in local.pset_customer_managed_policy_maps : "${pset.pset_name}.${pset.policy_name}" => pset }

  instance_arn       = local.ssoadmin_instance_arn
  permission_set_arn = aws_ssoadmin_permission_set.pset[each.value.pset_name].arn
  customer_managed_policy_reference {
    name = each.value.policy_name
    path = "/"
  }

}


# - Inline Policy -
resource "aws_ssoadmin_permission_set_inline_policy" "pset_inline_policy" {
  for_each = { for pset in local.pset_inline_policy_maps : pset.pset_name => pset if can(pset.inline_policy) }

  inline_policy      = each.value.inline_policy
  instance_arn       = local.ssoadmin_instance_arn
  permission_set_arn = aws_ssoadmin_permission_set.pset[each.key].arn
}

# - Permissions Boundary -
resource "aws_ssoadmin_permissions_boundary_attachment" "pset_permissions_boundary_aws_managed" {
  for_each = { for pset in local.pset_permissions_boundary_aws_managed_maps : pset.pset_name => pset if can(pset.boundary.managed_policy_arn) }

  instance_arn       = local.ssoadmin_instance_arn
  permission_set_arn = aws_ssoadmin_permission_set.pset[each.key].arn
  permissions_boundary {
    managed_policy_arn = each.value.boundary.managed_policy_arn
  }
}

resource "aws_ssoadmin_permissions_boundary_attachment" "pset_permissions_boundary_customer_managed" {
  for_each = { for pset in local.pset_permissions_boundary_customer_managed_maps : pset.pset_name => pset if can(pset.boundary.customer_managed_policy_reference) }

  instance_arn       = local.ssoadmin_instance_arn
  permission_set_arn = aws_ssoadmin_permission_set.pset[each.key].arn
  permissions_boundary {
    customer_managed_policy_reference {
      name = each.value.boundary.customer_managed_policy_reference.name
      path = can(each.value.boundary.customer_managed_policy_reference.path) ? each.value.boundary.customer_managed_policy_reference.path : "/"
    }

  }
}

# resource "aws_ssoadmin_account_assignment" "account_assignment" {
#   for_each = local.principals_and_their_account_assignments // for_each arguement must be a map, or set of strings. Tuples won't work

#   instance_arn       = local.ssoadmin_instance_arn
#   permission_set_arn = contains(local.this_permission_sets, each.value.permission_set) ? aws_ssoadmin_permission_set.pset[each.value.permission_set].arn : data.aws_ssoadmin_permission_set.existing_permission_sets[each.value.permission_set].arn

#   principal_type = each.value.principal_type

#   # Conditional use of resource or data source to reference the principal_id depending on if the principal_type is "GROUP" or "USER" and if the principal_idp is "INTERNAL" or "EXTERNAL". "INTERNAL" aligns with users or groups that were created with this module and use the default IAM Identity Store as the IdP. "EXTERNAL" aligns with users or groups that were created outside of this module (e.g. via external IdP such as EntraID, Okta, Google, etc.) and were synced via SCIM to IAM Identity Center.

#   principal_id = each.value.principal_type == "GROUP" && each.value.principal_idp == "INTERNAL" ? aws_identitystore_group.sso_groups[each.value.principal_name].group_id : (each.value.principal_type == "USER" && each.value.principal_idp == "INTERNAL" ? aws_identitystore_user.sso_users[each.value.principal_name].user_id : (each.value.principal_type == "GROUP" && each.value.principal_idp == "EXTERNAL" ? data.aws_identitystore_group.existing_sso_groups[each.value.principal_name].group_id : (each.value.principal_type == "USER" && each.value.principal_idp == "EXTERNAL" ? data.aws_identitystore_user.existing_sso_users[each.value.principal_name].user_id : (each.value.principal_type == "USER" && each.value.principal_idp == "GOOGLE") ? data.aws_identitystore_user.existing_google_sso_users[each.value.principal_name].user_id : null)))

#   target_id   = each.value.account_id
#   target_type = "AWS_ACCOUNT"
# }

# resource "aws_ssoadmin_account_assignment" "account_assignment" {
#   for_each = local.principals_and_their_account_assignments

#   instance_arn       = local.ssoadmin_instance_arn
#   permission_set_arn = contains(local.this_permission_sets, each.value.permission_set) ? aws_ssoadmin_permission_set.pset[each.value.permission_set].arn : data.aws_ssoadmin_permission_set.existing_permission_sets[each.value.permission_set].arn
#   principal_type     = each.value.principal_type
#   target_id          = each.value.account_id
#   target_type        = "AWS_ACCOUNT"

#   principal_id = (
#     each.value.principal_type == "GROUP" && each.value.principal_idp == "INTERNAL" ? aws_identitystore_group.sso_groups[each.value.principal_name].group_id :
#     each.value.principal_type == "USER" && each.value.principal_idp == "INTERNAL" ? aws_identitystore_user.sso_users[each.value.principal_name].user_id :
#     each.value.principal_type == "GROUP" && each.value.principal_idp == "EXTERNAL" ? data.aws_identitystore_group.existing_sso_groups[each.value.principal_name].group_id :
#     each.value.principal_type == "USER" && each.value.principal_idp == "EXTERNAL" ? data.aws_identitystore_user.existing_sso_users[each.value.principal_name].user_id :
#     each.value.principal_type == "USER" && each.value.principal_idp == "GOOGLE" ? data.aws_identitystore_user.existing_google_sso_users[each.value.principal_name].user_id :
#     null
#   )
# }

# resource "aws_ssoadmin_account_assignment" "account_assignment" {
#   for_each = { for assignment in local.assignments : 
#     "${assignment.account_id}-${assignment.principal_name}" => assignment
#   }

#   instance_arn       = local.ssoadmin_instance_arn
#   target_id          = each.value.account_id
#   target_type        = "AWS_ACCOUNT"
#   permission_set_arn = aws_ssoadmin_permission_set.pset[each.value.permission_set].arn
#   principal_type     = each.value.principal_type
#   principal_id       = (
#     each.value.principal_type == "GROUP" && each.value.principal_idp == "INTERNAL" ? aws_identitystore_group.sso_groups[each.value.principal_name].group_id :
#     each.value.principal_type == "USER" && each.value.principal_idp == "INTERNAL" ? data.aws_identitystore_user.existing_sso_users[each.value.principal_name].user_id :
#     each.value.principal_type == "GROUP" && each.value.principal_idp == "EXTERNAL" ? data.aws_identitystore_group.existing_sso_groups[each.value.principal_name].group_id :
#     each.value.principal_type == "USER" && each.value.principal_idp == "EXTERNAL" ? data.aws_identitystore_user.existing_sso_users[each.value.principal_name].user_id :
#     each.value.principal_type == "USER" && each.value.principal_idp == "GOOGLE" ? data.aws_identitystore_user.existing_google_sso_users[each.value.principal_name].user_id :
#     null
#   )
# }
resource "aws_ssoadmin_account_assignment" "account_assignment" {
  for_each = {
    for assignment in flatten(local.assignments) :
    "${assignment.account_id}-${assignment.principal_name}" => assignment
  }

  instance_arn       = local.ssoadmin_instance_arn
  target_id          = each.value.account_id
  target_type        = "AWS_ACCOUNT"
  permission_set_arn = aws_ssoadmin_permission_set.pset[each.value.permission_set].arn   
  principal_type     = "GROUP"
  principal_id       = local.group_ids[each.value.principal_name]
}













