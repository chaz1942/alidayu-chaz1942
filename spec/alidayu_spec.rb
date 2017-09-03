require 'spec_helper'

describe Alidayu do

  it 'has a version number' do
    expect(Alidayu::VERSION).not_to be nil
  end

  it 'can send message' do
    Alidayu.access_key_id = ''
    Alidayu.access_key_secrete = ''
    status = Alidayu.send_text_message(
        {
            PhoneNumbers: 'xxxxxxx',
            TemplateParam: {code: '1234'},
            SignName: '中拓明光',
            TemplateCode: 'SMS_83955030'
        })
    puts status
  end

  it 'can get right signature' do
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
        OutId: '123'
    }
    signature = Alidayu.get_signature signature_params
    expect(signature).equal?('zJDF%2BLrzhj%2FThnlvIToysFRq6t4%3D')
  end
end
