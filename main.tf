


data "aws_ami_ids" "ami_ids" {
owners = [var.source_account_id]
}

resource "aws_ami_launch_permission" "ami_permissions" {
for_each = {for object in data.aws_ami_ids.ami_ids.ids : object => object}
  image_id   = each.key
  account_id = var.dest_account_id
}

data "aws_ebs_snapshot_ids" "snapshot_ids" {
owners = [var.source_account_id]
}

resource "aws_snapshot_create_volume_permission" "snaphot_permissions" {
for_each = {for object in data.aws_ebs_snapshot_ids.snapshot_ids.ids : object => object}
  snapshot_id   = each.key
  account_id = var.dest_account_id
}