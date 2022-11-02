<html>
<h2>Terraform SG&NACL TEST</h2>
ex) 22 PORT Allow OR Denied // 모든 포트에 대하여 적용 가능<br />
1. PORT 22번을 기준으로 subnet의 NACL이 22번 포트와 관련된 룰이 존재하는지를 본다.<br />
x.1 : 안전한 경우와 안전하지 않은 경우를 나눈다.<br />
<hr />
<h3>용어 정리</h3>
Target              : 탐색하고자하는 대상<br />
Target.subnet       : Target의 서브넷<br />
Target.NACL(port)   : Target이 속한 서브넷의 NACL<br />
Target.SG(port)     : Target의 security group <br />

<hr />
<h3>SAMPLE</h3>
<ul>
<li> Target.SG(22)가 설정되어있다.</li>
      <ul> <li>Target.NACL(All Denied) + Target.NACL(22) Allow </li>
            <ul>
            <li> PASS </li>
              - Target.NACL(22) >= Target.SG(22) || Target.subnet >= Target.SG(22) <br />
                  &nbsp;&nbsp;&nbsp; : SG(22) 대역대는 NACL(22)의 대역대에 포함된다.  <br />
                  &nbsp;&nbsp;&nbsp; : SG(22) 대역대는 서브넷 대역대에 포함된다. <br />
            <li> FAIL </li>
              - !(Target.NACL(22) >= Target.SG(22)) && Target.subnet != Target.SG(22)<br />
                  &nbsp;&nbsp;&nbsp; : SG(22) 대역대는 NACL(22)의 대역대에 포함되지 않는다.<br />
                  &nbsp;&nbsp;&nbsp; : SG(22) 대역대는 서브넷 대역대에 포함되지 않는다.<br />
            </ul>
      </ul>
<ul> <li>Target.NACL 22 Denied </li>
            <ul>
                  <li> PASS </li>
                    - !(Target.NACL(22) > Target.SG(22))<br />
                        &nbsp;&nbsp;&nbsp; : SG(22) 대역대는 NACL(22)의 대역대에 포함되지 않는다.<br />
                  <li> FAIL </li>
                    - Target.NACL(22) > Target.SG(22)<br />
                        &nbsp;&nbsp;&nbsp; : SG(22) 대역대는 NACL(22)의 대역대에 포함된다.<br />
            </ul>
      </ul>
      <ul>
         <li> Target.NACL 22 관련 룰이 존재하지않는다. </li>
            -> 확인 불가
      </ul>
<li> Tatget.SG(22)가 설정되어있지 않다. </li>
   PASS

</ul>
</html>
