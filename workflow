name: second workflow
on: push
jobs:
  first_job:
    runs-on: ubuntu-latest
    steps:
    - name: using actions
      uses: actions/checkout@v4
    - name: welcome message
      run: ls