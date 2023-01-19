# frozen_string_literal: true
module HubspotService
  class Client

    def initialize()
      @client = Hubspot.configure(access_token: ENV["HUBSPOT_ACCESS_TOKEN"])
    end

    def self.owner_by_email
      owner = Hubspot::Owner.find_by_email("gemharedu@gmail.com")
    end

    def self.contact_by_id
      contact = Hubspot::Contact.find_by_id(1)
    end

    def self.all_contacts
      # yes
      response = Hubspot::Contact.all
    end

    # PUT/POST
    def self.createOrUpdate
      # yes
      params = { email: "gemharjob@gmail.Company",
        firstname: "gems",
        lastname: "jobber",
        jobtitle: "SDE",
        address: "test",
        city: "test city",
        state: "test state",
        zip: "test zip",
        country: "test country",
        phone: "test phone" }
        Hubspot::Contact.createOrUpdate(params[:email], map_user_params_to_hubspot_params(params))
    end

    def self.all_contact_properties
      # yes
      Hubspot::ContactProperties.all
    end

    def self.all_contact_properties_with_params
      # yes
      contact_properties = Hubspot::ContactProperties.all({}, {})
    end

    # PUT/POST
    def self.create_deal
      # yes
      if force && params
        Hubspot::Deal.create!(nil, 1, 1)
      end
    end

    def self.all_deal_pipelines
      # yes
      pipelines = Hubspot::DealPipeline.all
    end

    def self.all_companies
      # yes
      # DEFAULT_IMPORT_PAGE_SIZE = 25
      response = Hubspot::Company.all(recently_updated: true, count: 25, offset: 0)
    end

    def self.parent_company(child_id)
      # yes 
      # same as Hubspot::Connection.get_json(GET_PARENT_COMPANY, params)
      # parent_id = Hubspot::Company.parent_company(child_id.try(:to_i)).try(:first)
    end

    def self.all_companies_with_props()
      # same as   response = Hubspot::Connection.get_json(path, opts)
      # response, tmp_pulled_entities = Hubspot::Company.all_companies( limit: 200, offset: 0,
        # properties: ["name", "include_in_app", "type", "hs_lastmodifieddate"] )
    end

    def self.all_company_pros
      # yes
      properties = Hubspot::CompanyProperties.all
    end

    def self.all_company_pros_with_empty_props
      # yes
      company_properties = Hubspot::CompanyProperties.all({}, {})
    end

    def self.all_company_pros_with_props
      # yes
      metadata_properties = Hubspot::CompanyProperties.all({}, include: ['integration_metadata'])
    end

    def self.raise_error()
      raise Hubspot::InvalidParams, 'expecting Integer parameter'
    end

    def self.connection_with_params
      params = { definitionId: 14, objectId: 6823395832 }
      response = Hubspot::Connection.get_json('/crm-associations/v1/associations/:objectId/HUBSPOT_DEFINED/:definitionId', params)
    end

    def self.connection_with_path
      opts = {"has-more"=>true, "offset"=>1098940636, "companies"=>[]}
      response = Hubspot::Connection.get_json("/companies/v2/companies/paged", opts)
    end
  end
end