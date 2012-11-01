module Xero
  module Models

    class Account < BaseModel

      self.path = 'Accounts'

      TYPE = {
        'CURRENT' =>        '',
        'FIXED' =>          '',
        'PREPAYMENT' =>     '',
        'EQUITY' =>         '',
        'DEPRECIATN' =>     '',
        'DIRECTCOSTS' =>    '',
        'EXPENSE' =>        '',
        'OVERHEADS' =>      '',
        'CURRLIAB' =>       '',
        'LIABILITY' =>      '',
        'TERMLIAB' =>       '',
        'OTHERINCOME' =>    '',
        'REVENUE' =>        '',
        'SALES' =>          ''
      } unless defined?(TYPE)

      TAX_TYPE = {
        'NONE' =>             'No GST',
        'EXEMPTINPUT' =>      'VAT on expenses exempt from VAT (UK only)',
        'INPUT' =>            'GST on expenses',
        'SRINPUT' =>          'VAT on expenses',
        'ZERORATEDINPUT' =>   'Expense purchased from overseas (UK only)',
        'RRINPUT' =>          'Reduced rate VAT on expenses (UK Only)', 
        'EXEMPTOUTPUT' =>     'VAT on sales exempt from VAT (UK only)',
        'ECZROUTPUT' =>       'EC Zero-rated output',
        'OUTPUT' =>           'OUTPUT (old rate)',
        'OUTPUT2' =>          'OUTPUT2',
        'SROUTPUT' =>         'SROUTPUT',
        'ZERORATEDOUTPUT' =>  'Sales made from overseas (UK only)',
        'RROUTPUT' =>         'Reduced rate VAT on sales (UK Only)',
        'ZERORATED' =>        'Zero-rated supplies/sales from overseas (NZ Only)'
      } unless defined?(TAX_TYPE)

      attribute :id
      attribute :code
      attribute :name
      attribute :account_type
      attribute :tax_type
      attribute :description
      attribute :system_account
      attribute :enable_payments_to_account, type: Boolean
      attribute :bank_account_number
      attribute :currency_code

      # def self.from_xml(xml)
      #   attrs = Hash.from_xml(xml)['Accounts']['Account']

      #   attrs['id'] = attrs.delete('AccountID')
      #   attrs['account_type'] = attrs.delete('Type')
      #   attrs.keys.each do |key|
      #     attrs[key.tableize.singularize] = attrs.delete(key)
      #   end

      #   self.new(attrs)
      # end
    end
  end
end
