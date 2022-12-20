  <h3>cand2</h3>
  <p>Contents : A Policy를 두번 할당한 경우 한개의 Policy를 변경했을 때 A Policy가 존재하지 않게 된다. </p>
  <hr />
  <h3>SAMPLE</h3>
  
  Before <br />
![image](https://user-images.githubusercontent.com/53141739/199475266-e348a9c0-47d1-47f0-9018-393a9d8388b9.png)

  After <br />
![image](https://user-images.githubusercontent.com/53141739/199475514-02b6e72e-0ba3-431a-9ead-398c1a5cd1ee.png)

Before -> [Apply] -> After -> [Apply] <br />
적용 시 : policy_arn = module.IAM.iam_policy_cand1_id 이 존재하지 않음
