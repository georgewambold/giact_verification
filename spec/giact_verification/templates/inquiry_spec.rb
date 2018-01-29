require 'spec_helper'

describe 'inquiry XML template' do
  def filled_template
    @filled_template = GiactVerification::TemplateRenderer.new(
      template_name: 'inquiry',
      substitutions: substitutions
    ).render
  end

  def substitutions
    {
      unique_id: 'some_unique_id',
      g_verify_enabled: 'some_g_verify_enabled_value',
      funds_confirmation_enabled: 'some_funds_confirmation_enabled_value',
      g_authenticate_enabled: 'some_g_authenticate_enabled_value',
      voided_check_image_enabled: 'some_voided_check_image_enabled_value',
      g_identify_enabled: 'some_g_identify_enabled_value',
      customer_id_enabled: 'some_customer_id_enabled_value',
      ofac_scan_enabled: 'some_ofac_scan_enabled_value',
      g_identify_esi_enabled: 'some_g_identify_esi_enabled',
      ip_address_information_enabled: 'some_ip_address_information_enabled_value',
      domain_whois_enabled: 'some_domain_whois_enabled_value',
      mobile_verify_enabled: 'some_mobile_verify_enabled_value',
      mobile_identify_enabled: 'some_mobile_identify_enabled_value',
      customer: {
        name_prefix: 'some_name_prefix',
        first_name: 'some_first_name',
        middle_name: 'some_middle_name',
        last_name: 'some_last_name',
        name_suffix: 'some_name_suffix',
        address_line_1: 'some_address_line_1',
        address_line_2: 'some_address_line_2',
        city: 'some_city',
        state: 'some_state',
        zip_code: 'some_zip_code',
        country: 'some_country',
        phone_number: 'some_phone_number',
        tax_id: 'some_tax_id',
        date_of_birth: 'some_date',
        drivers_license_number: 'some_drivers_license_number',
        drivers_license_state: 'some_drivers_license_state',
        email_address: 'some_email_address',
        current_ip_address: 'some_ip_address',
        alternative_id_type: 'some_alternative_id_type',
        alternative_id_number: 'some_alternative_id_number',
        domain: 'some_domain',
      },
      check: {
        routing_number: 'some_routing_number',
        account_number: 'some_account_number',
        account_type:   'some_account_type',
        check_number:   'some_check_number',
        check_amount:   'some_check_amount'
      }
    }
  end

  context 'inquiry' do
    it 'renders a unique_id substitution' do
      expect(filled_template).to include('some_unique_id')
    end

    it 'renders a g_verify_enabled substitution' do
      expect(filled_template).to include('some_g_verify_enabled_value')
    end

    it 'renders a funds_confirmation_enabled substitution' do
      expect(filled_template).to include('some_funds_confirmation_enabled_value')
    end

    it 'renders a g_authenticate_enabled substitution' do
      expect(filled_template).to include('some_g_authenticate_enabled_value')
    end

    it 'renders a voided_check_image_enabled substitution' do
      expect(filled_template).to include('some_voided_check_image_enabled_value')
    end

    it 'renders a g_identify_enabled substitution' do
      expect(filled_template).to include('some_g_identify_enabled_value')
    end

    it 'renders a customer_id_enabled substitution' do
      expect(filled_template).to include('some_customer_id_enabled_value')
    end

    it 'renders a ofac_scan_enabled substitution' do
      expect(filled_template).to include('some_ofac_scan_enabled_value')
    end

    it 'renders a g_identify_esi_enabled substitution' do
      expect(filled_template).to include('some_g_identify_esi_enabled')
    end

    it 'renders a ip_address_information_enabled substitution' do
      expect(filled_template).to include('some_ip_address_information_enabled_value')
    end

    it 'renders a domain_whois_enabled substitution' do
      expect(filled_template).to include('some_domain_whois_enabled_value')
    end

    it 'renders a mobile_verify_enabled substitution' do
      expect(filled_template).to include('some_mobile_verify_enabled_value')
    end

    it 'renders a mobile_identify_enabled substitution' do
      expect(filled_template).to include('some_mobile_identify_enabled_value')
    end

    context 'check' do
      it 'renders a routing_number substitution' do
        expect(filled_template).to include('some_routing_number')
      end

      it 'renders a account_number substitution' do
        expect(filled_template).to include('some_account_number')
      end

      it 'renders a account_type substitution' do
        expect(filled_template).to include('some_account_type')
      end

      it 'renders a check_number substitution' do
        expect(filled_template).to include('some_check_number')
      end

      it 'renders a check_amount substitution' do
        expect(filled_template).to include('some_check_amount')
      end
    end

    context 'customer' do
      it 'renders a name_prefix substitution' do
        expect(filled_template).to include('some_name_prefix')
      end

      it 'renders a first_name substitution' do
        expect(filled_template).to include('some_first_name')
      end

      it 'renders a middle_name substitution' do
        expect(filled_template).to include('some_middle_name')
      end

      it 'renders a last_name substitution' do
        expect(filled_template).to include('some_last_name')
      end

      it 'renders a name_suffix substitution' do
        expect(filled_template).to include('some_name_suffix')
      end

      it 'renders a address_line_1 substitution' do
        expect(filled_template).to include('some_address_line_1')
      end

      it 'renders a address_line_2 substitution' do
        expect(filled_template).to include('some_address_line_2')
      end

      it 'renders a city substitution' do
        expect(filled_template).to include('some_city')
      end

      it 'renders a state substitution' do
        expect(filled_template).to include('some_state')
      end

      it 'renders a zip_code substitution' do
        expect(filled_template).to include('some_zip_code')
      end

      it 'renders a country substitution' do
        expect(filled_template).to include('some_country')
      end

      it 'renders a phone_number substitution' do
        expect(filled_template).to include('some_phone_number')
      end

      it 'renders a tax_id substitution' do
        expect(filled_template).to include('some_tax_id')
      end

      it 'renders a date_of_birth substitution' do
        expect(filled_template).to include('some_date')
      end

      it 'renders a drivers_license_number substitution' do
        expect(filled_template).to include('some_drivers_license_number')
      end

      it 'renders a drivers_license_state substitution' do
        expect(filled_template).to include('some_drivers_license_state')
      end

      it 'renders a email_address substitution' do
        expect(filled_template).to include('some_email_address')
      end

      it 'renders a current_ip_address substitution' do
        expect(filled_template).to include('some_ip_address')
      end

      it 'renders a alterantive_id_type substitution' do
        expect(filled_template).to include('some_alternative_id_type')
      end

      it 'renders a alterantive_id_number substitution' do
        expect(filled_template).to include('some_alternative_id_number')
      end

      it 'renders a domain substitution' do
        expect(filled_template).to include('some_domain')
      end
    end
  end
end
