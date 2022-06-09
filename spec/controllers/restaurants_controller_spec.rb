# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RestaurantsController, type: :controller do
  let(:user) { FactoryBot.create :user }
  let(:admin) { FactoryBot.create :admin }
  let(:restaurant) { FactoryBot.create :restaurant }

  describe 'GET index' do
    it 'returns a successful response for all users' do
      get :index
      expect(response).to be_successful
    end

    it 'renders the index template for all users' do
      get :index
      expect(response).to render_template('index')
    end

    it 'returns @restaurants for all users' do
      get :index
      expect(assigns(:restaurants)).to eq([restaurant])
    end
  end

  describe 'GET new' do
    context 'with unauthenticated users' do
      before { allow(controller).to receive(:current_user).and_return(nil) }

      it 'redirects' do
        get :new
        expect(response.status).to eq(302)
      end

      it 'redirects to root path' do
        get :new
        expect(response).to redirect_to(root_path)
      end
    end

    context 'with non-admin users' do
      before { allow(controller).to receive(:current_user).and_return(user) }

      it 'redirects' do
        get :new
        expect(response.status).to eq(302)
      end

      it 'redirects to root path' do
        get :new
        expect(response).to redirect_to(root_path)
      end
    end

    context 'with admin users' do
      before { allow(controller).to receive(:current_user).and_return(admin) }

      it 'returns successfull for admin' do
        get :new
        expect(response).to be_successful
      end

      it 'renders the new template for admin' do
        get :new
        expect(response).to render_template('new')
      end

      it 'creates new restaurant' do
        get :new
        expect(assigns(:restaurant)).to be_a_new(Restaurant)
      end
    end
  end

  describe 'POST create' do
    context 'with unauthenticated users' do
      before { allow(controller).to receive(:current_user).and_return(nil) }

      it 'redirects' do
        post :create
        expect(response.status).to eq(302)
      end

      it 'redirects to root path' do
        post :create
        expect(response).to redirect_to(root_path)
      end
    end

    context 'with non-admin users' do
      before { allow(controller).to receive(:current_user).and_return(user) }

      it 'redirects' do
        post :create
        expect(response.status).to eq(302)
      end

      it 'redirects to root path' do
        post :create
        expect(response).to redirect_to(root_path)
      end
    end

    context 'with admin users' do
      let(:valid_params) do
        {
          restaurant: {
            name: 'Ranchers',
            location: 'Islamabad'
          }
        }
      end

      before { allow(controller).to receive(:current_user).and_return(admin) }

      it 'creates a new restaurant' do
        expect { post :create, params: valid_params }.to change(Restaurant, :count).by(+1)
      end

      it 'creates a restaurant with correct attributes' do
        post :create, params: valid_params
        expect(Restaurant.last).to have_attributes valid_params[:restaurant]
      end

      it 'redirects to admin_index_template' do
        post :create, params: valid_params
        expect(response).to redirect_to(admins_index_path)
      end

      it 'sets the flash for success' do
        post :create, params: valid_params
        expect(flash[:notice]).to be_present
      end

      it 'sets error flash for invalid attributes' do
        valid_params[:restaurant][:name] = nil
        post :create, params: valid_params
        expect(flash[:alert]).to be_present
      end

      it 'renders new template for invalid attributes' do
        valid_params[:restaurant][:name] = nil
        post :create, params: valid_params
        expect(response).to render_template('new')
      end
    end
  end
end
