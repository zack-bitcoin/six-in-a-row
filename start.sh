#if you want to use a different port, then start like this:
# sh start 3666
#git pull origin master

./rebar get-deps
./rebar compile #this line checks if any modules were modified, and recompiles them if they were. only needed during testing.
#echo "GO TO THIS WEBSITE -------> http://localhost:3011/login.html"
erl -pa ebin deps/*/ebin/ -eval "application:ensure_all_started(testnet), serve:pw($1)"
