# GraphQL-iOS-test

General notes:
1. It was my first time ever doing anything with GraphQL or Apollo. I was following this tutorial: https://www.apollographql.com/docs/ios/tutorial/tutorial-introduction/ and also used my intuition to improve the code a bit but I won't be surprised if it doesn't show the best practices.
2. My intention was to use MVVM. I didn't want to introduce any 3rd party libs other than Apollo so I created a simple closure-based binding rather than importing RxSwift or Combine. That also saved me some time with unit tests.
3. I put very little effort on creating UI as suggested in the task description though I removed storyboards and wrote the UI in code as I do in my production code.
