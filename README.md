# Alidayu

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/alidayu`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'alidayu'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install alidayu

## Usage

Step 1. Set you accsess key id and access secrete
```ruby
  Alidayu.access_key_id = 'YOUR ACCESS KEY ID'
  Alidayu.access_key_secrete = 'YOUR ACCESS KEY SECRET'
```
Step 2. send text message
```ruby
Alidayu.send_text_message({
  PhoneNumbers: 'xxxxxxx',
  TemplateParam: {code: '1234'},//accroding to template you set, for example my template content is '您的验证码${code}', the message you receive is 您的验证码1234
  SignName: 'sms signe name',
  TemplateCode: 'sms template code'})
```
alidayu using a protocal 'POP' create by themself, so you also an using this gem to sign you params
according to [official guide](https://help.aliyun.com/document_detail/56189.html?spm=5176.doc55284.6.567.wG44n1) . there is example for signature, this is params:
```ruby
  signature_params = {
    Timestamp: '2017-07-12T02:42:19Z',
    SignatureMethod: 'HMAC-SHA1',
    SignatureVersion: '1.0',
    SignatureNonce: '45e25e9b-0a6f-4070-8c85-2956eda1b466',
    Action: 'SendSms',
    Version: '2017-05-25',
    RegionId: 'cn-hangzhou',
    PhoneNumbers: '15300000001',
    SignName: '阿里云短信测试专用',
    TemplateCode: 'SMS_71390007',
    TemplateParam:  "{\"customer\":\"test\"}",
    Format: 'XML',
    OutId: '123'}
```
signature is ```ruby
zJDF+Lrzhj/ThnlvIToysFRq6t4=
```
```ruby
  Alidayu.access_key_id = 'testId'
  Alidayu.access_key_secrete = 'testSecret'
  signature_params = {
    Timestamp: '2017-07-12T02:42:19Z',
    SignatureMethod: 'HMAC-SHA1',
    SignatureVersion: '1.0',
    SignatureNonce: '45e25e9b-0a6f-4070-8c85-2956eda1b466',
    Action: 'SendSms',
    Version: '2017-05-25',
    RegionId: 'cn-hangzhou',
    PhoneNumbers: '15300000001',
    SignName: '阿里云短信测试专用',
    TemplateCode: 'SMS_71390007',
    TemplateParam:  "{\"customer\":\"test\"}",
    Format: 'XML',
    OutId: '123'}
   signature = Alidayu.get_signature signature_params
```
the signature is ```zJDF%2BLrzhj%2FThnlvIToysFRq6t4%3D'``` it encode by Base64


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/alidayu. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

