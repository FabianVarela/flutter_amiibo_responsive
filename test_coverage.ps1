flutter test --coverage
dart run remove_from_coverage -f coverage/lcov.info -r '\.g\.dart$'
dart run remove_from_coverage -f coverage/lcov.info -r '\.freezed\.dart$'
perl C:\ProgramData\chocolatey\lib\lcov\tools\bin\genhtml -o coverage\html coverage\lcov.info
coverage/html/index.html