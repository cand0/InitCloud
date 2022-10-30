<html>
<body>

<h2>Module Input Validation Check</h2>
&nbsp&nbspNormal : Code in 0.0.0.0 <br />
&nbsp&nbspStatic : Module in 0.0.0.0<br />
&nbsp&nbspVariable : 0.0.0.0 When calling module from tf file<br />

<h2>Step</h2>
<h3>Result</h3>
<p>&nbsp&nbspcheckOV does not support module input validation check</p>
<h5>Variable</h5>
&nbsp&nbspNot Found

<h5>Normal</h5>
Check: CKV_AWS_24: "Ensure no security groups allow ingress from 0.0.0.0:0 to port 22" <br />
&nbsp&nbsp	FAILED for resource: aws_security_group.cand1_1<br />
&nbsp&nbsp	File: /Normal.tf:17-36<br />
&nbsp&nbsp	Guide: https://docs.bridgecrew.io/docs/networking_1-port-security<br />

<h5>Static</h5>
Check: CKV_AWS_24: "Ensure no security groups allow ingress from 0.0.0.0:0 to port 22"<br />
&nbsp&nbsp	FAILED for resource: module.sg.aws_security_group.cand1_1<br />
&nbsp&nbsp	File: /module/sg/Static_sg.tf:1-20<br />
&nbsp&nbsp	Calling File: /Static.tf:8-11<br />
&nbsp&nbsp	Guide: https://docs.bridgecrew.io/docs/networking_1-port-security<br />

</body>
</html>
