<html>
<body>

<h2>Module Input Validation Check</h2>
Normal : Code in 0.0.0.0
Static : Module in 0.0.0.0
Variable : 0.0.0.0 When calling module from tf file

<h2>Step</h2>
<h3>Result</h3>
<p>checkOV does not support module input validation check</p>
<h5>Variable</h5>
Not Found

<h5>Normal</h5>
Check: CKV_AWS_24: "Ensure no security groups allow ingress from 0.0.0.0:0 to port 22"
	FAILED for resource: aws_security_group.cand1_1
	File: /Normal.tf:17-36
	Guide: https://docs.bridgecrew.io/docs/networking_1-port-security

<h5>Static</h5>
Check: CKV_AWS_24: "Ensure no security groups allow ingress from 0.0.0.0:0 to port 22"
	FAILED for resource: module.sg.aws_security_group.cand1_1
	File: /module/sg/Static_sg.tf:1-20
	Calling File: /Static.tf:8-11
	Guide: https://docs.bridgecrew.io/docs/networking_1-port-security

</body>
</html>
