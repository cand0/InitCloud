### check

---

#### resource
aws_snapshot_create_volume_permission

#### level
medium

### explanation

---

aws_snapshot_create_volume_permission은 다른 accountid에서 snapshot에 접근할 수 있는 권한을 주는 리소스로 같은 계정을 중복선언 하면 하나의 정책만 적용이 된다. <br />

따라서 aws_snapshot_create_volume_permission 내에 같은 account_id와 snapshot_id를 선언하면 안된다.

### insecure example

---

```go
resource "aws_snapshot_create_volume_permission" "fail1_1" {
  snapshot_id = aws_ebs_snapshot.example_snapshot.id
  account_id  = "12345678"
}
resource "aws_snapshot_create_volume_permission" "fail1_2" {
  snapshot_id = aws_ebs_snapshot.example_snapshot.id
  account_id  = "12345678"
}
```


### secure example

---

```go
resource "aws_snapshot_create_volume_permission" "pass" {
  snapshot_id = aws_ebs_snapshot.example_snapshot.id
  account_id  = "12345678"
}

```

