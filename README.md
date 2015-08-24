## Prerequisites

#### OS X

1. Update homebrew `brew update`
2. Install jMeter `brew install jmeter`
3. Clone repo
	
#### Windows

1. [Ensure Java is installed](https://www.java.com/en/download/help/windows_manual_download.xml)
2. Install jMeter: [download](http://jmeter.apache.org/download_jmeter.cgi)
3. Clone repo

#### How does it work?

__jMeter__ uses XML configuration OR it's archaic UI to configure load testing settings. Both are notoriously difficult to decipher. It's widely accepted that jMeter is the kind of application that makes you want to 😢

__ruby-jmeter__ attempts to alleviate this pain by introducing a ruby DSL that *generates* jMeter XML files. For the most part, this works very well. 

1. Open the __load-testing__ project
1. Find `ruby_jmeter_scripts/example.rb`
1. Notice the ruby based directives for the following browser actions:
	* `cookies policy: 'default', clear_each_iteration: true` - accept cookies. Otherwise, we'd never be able to log in.
	* `cache clear_each_iteration: true` - don't cache the web page.
	* `visit name: 'Some Action', url: HOST_NAME + '/some/action'` - kick off a web request
	* full list of directives can be found on the [ruby-jmeter](https://github.com/flood-io/ruby-jmeter#advanced-usage) page
1. Execute our script to generate a jMeter XML (jmeter.xml) configuration file: `ruby ruby_jmeter_scripts/example.rb`
1. Launch jMeter
	* Windows: double-click the `jmeter.bat` file in the `\bin` folder
	* OS X: run `jmeter` from the console
1. Open the generated jmeter.jmx file, located in the load-testing project folder
1. Hit the green "play" buttong to begin testing

#### Settings to tweak

`threads count: 1, duration: 10`

* count - think of this as # of users
* duration - length of the test

#### Rails CSRF considerations

1. Extract the CSRF

```
extract name: 'csrf-token', xpath: "//meta[@name='csrf-token']/@content", tolerant: true
extract name: 'csrf-param', xpath: "//meta[@name='csrf-param']/@content", tolerant: true
```

2. Inject the CSRF back into the headers

`http_header_manager name: 'X-CSRF-Token', value: '${csrf-token}'`
 
