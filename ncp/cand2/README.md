<h1>ncloud_network_acl_rule</h1>
코드가 변경되지 않아도 계속 apply가 가능하다.

<h2>testcode 1</h2>

우선순위가 같으면 apply때마다 둘 중 하나만 apply가 적용된다.
![image](https://user-images.githubusercontent.com/53141739/200785877-87e3a974-013c-428c-9788-9cbf1f1c8eda.png) <br />
위 에러는 처음 한번만 뜨고 더이상 뜨지 않는다.


<h2>testcode 2</h2>
우선순위가 다르면 둘다 적용이 되지만, 다시 apply를 아래와 같은 오류와 함께 하면 두개의 룰 모두 사라진다.

![image](https://user-images.githubusercontent.com/53141739/200786016-12e40855-cd53-4d6a-9509-32c57b9cc1ce.png)
![image](https://user-images.githubusercontent.com/53141739/200786019-ef194dfe-f63b-4720-8282-69e2a4697e24.png)
