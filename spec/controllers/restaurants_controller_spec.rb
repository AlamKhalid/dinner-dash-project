# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RestaurantsController, type: :controller do
  let(:user) { FactoryBot.create :user }
  let(:admin) { FactoryBot.create :admin }
  let(:restaurant) { FactoryBot.create :restaurant }
  let(:item) { FactoryBot.create :item }

  describe 'GET index' do
    it 'returns a successful response with index template and restaurants' do
      get :index
      expect(response).to be_successful
      expect(response.status).to eq(200)
      expect(response).to render_template('index')
      expect(assigns(:restaurants)).to eq([restaurant])
    end
  end

  describe 'GET new' do
    context 'with unauthenticated users' do
      before { allow(controller).to receive(:current_user).and_return(nil) }

      it 'redirects to root path' do
        get :new
        expect(response.status).to eq(302)
        expect(response).to redirect_to(root_path)
      end
    end

    context 'with non-admin users' do
      before { allow(controller).to receive(:current_user).and_return(user) }

      it 'redirects to root path' do
        get :new
        expect(response.status).to eq(302)
        expect(response).to redirect_to(root_path)
      end
    end

    context 'with admin users' do
      before { allow(controller).to receive(:current_user).and_return(admin) }

      it 'returns successfull with new template and restaurant for admin' do
        get :new
        expect(response).to be_successful
        expect(response.status).to eq(200)
        expect(response).to render_template('new')
        expect(assigns(:restaurant)).to be_a_new(Restaurant)
      end
    end
  end

  describe 'POST create' do
    context 'with unauthenticated users' do
      before { allow(controller).to receive(:current_user).and_return(nil) }

      it 'redirects to root path' do
        post :create
        expect(response.status).to eq(302)
        expect(response).to redirect_to(root_path)
      end
    end

    context 'with non-admin users' do
      before { allow(controller).to receive(:current_user).and_return(user) }

      it 'redirects to root path' do
        post :create
        expect(response.status).to eq(302)
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

      it 'creates a new restaurant in database' do
        expect { post :create, params: valid_params }.to change(Restaurant, :count).by(1)
      end

      it 'creates a restaurant with correct attributes, flash and redirection' do
        post :create, params: valid_params
        expect(Restaurant.last).to have_attributes valid_params[:restaurant]
        expect(response.status).to eq(302)
        expect(response).to redirect_to(admins_index_path)
        expect(flash[:notice]).to be_present
      end

      it 'sets error flash for invalid attributes and renders new template' do
        valid_params[:restaurant][:name] = nil
        post :create, params: valid_params
        expect(flash[:alert]).to be_present
        expect(response.status).to eq(200)
        expect(response).to render_template('new')
      end
    end
  end

  describe 'GET edit' do
    context 'with unauthenticated users' do
      before { allow(controller).to receive(:current_user).and_return(nil) }

      it 'redirects to root path' do
        get :edit, params: { id: restaurant.id }
        expect(response.status).to eq(302)
        expect(response).to redirect_to(root_path)
      end
    end

    context 'with non-admin users' do
      before { allow(controller).to receive(:current_user).and_return(user) }

      it 'redirects to root path' do
        get :edit, params: { id: restaurant.id }
        expect(response.status).to eq(302)
        expect(response).to redirect_to(root_path)
      end
    end

    context 'with admin users' do
      before { allow(controller).to receive(:current_user).and_return(admin) }

      it 'returns successful' do
        get :edit, params: { id: restaurant.id }
        expect(response).to be_successful
        expect(response.status).to eq(200)
        expect(response).to render_template('edit')
        expect(assigns(:restaurant)).to be_a(Restaurant)
      end
    end
  end

  describe 'PUT update' do
    context 'with unauthenticated users' do
      before { allow(controller).to receive(:current_user).and_return(nil) }

      it 'redirects to root path' do
        put :update, params: { id: restaurant.id, restaurant: restaurant }
        expect(response.status).to eq(302)
        expect(response).to redirect_to(root_path)
      end
    end

    context 'with non-admin users' do
      before { allow(controller).to receive(:current_user).and_return(user) }

      it 'redirects to root path' do
        put :update, params: { id: restaurant.id, restaurant: restaurant }
        expect(response.status).to eq(302)
        expect(response).to redirect_to(root_path)
      end
    end

    context 'with admin users' do
      let(:updated_params) do
        {
          name: 'Ranchers',
          location: 'Islamabad'
        }
      end

      before { allow(controller).to receive(:current_user).and_return(admin) }

      it 'returns successful with update template and correct variables' do
        put :update, params: { id: restaurant.id, restaurant: updated_params, format: 'js' }
        expect(response).to be_successful
        expect(response.status).to eq(200)
        expect(response).to render_template('update')
        expect(assigns(:restaurant)).to be_a(Restaurant)
        expect(assigns(:flash_msg)).to be_present
        expect(assigns(:flash_msg)).to match('Updated Restaurant successfully')
        expect(assigns(:class_alert)).to be_present
        expect(assigns(:class_alert)).to match('alert-success')
      end

      it 'returns 404 for invalid restaurant id' do
        put :update, params: { id: -1, restaurant: updated_params, format: 'js' }
        expect(response.status).to eq(404)
      end

      it 'populates error messages for invalid data' do
        updated_params[:name] = nil
        put :update, params: { id: restaurant.id, restaurant: updated_params, format: 'js' }
        expect(response).to be_successful
        expect(response.status).to eq(200)
        expect(response).to render_template('update')
        expect(assigns(:flash_msg)).to be_present
        expect(assigns(:flash_msg)).to match('An error occured')
        expect(assigns(:class_alert)).to be_present
        expect(assigns(:class_alert)).to match('alert-danger')
      end
    end
  end

  describe 'PUT category_filter' do
    context 'when valid' do
      it 'returns items with specific category' do
        put :category_filter, params: { restaurant_id: item.restaurant.id, category_name: item.categories[0].name,
                                        format: 'js' }
        expect(response).to be_successful
        expect(response.status).to eq(200)
        expect(assigns(:items)).to eq([item])
      end

      it 'returns all items for all category' do
        put :category_filter, params: { restaurant_id: restaurant.id, category_name: 'all', format: 'js' }
        expect(response).to be_successful
        expect(response.status).to eq(200)
        expect(assigns(:items)).to eq(restaurant.items)
      end

      it 'returns empty items array for non-existent category' do
        put :category_filter, params: { restaurant_id: restaurant.id, category_name: 'nil', format: 'js' }
        expect(response).to be_successful
        expect(response.status).to eq(200)
        expect(assigns(:items)).to eq([])
      end
    end
  end

  describe 'GET show' do
    it 'returns successful response and sets restaurant and items' do
      get :show, params: { id: restaurant.id }
      expect(response).to be_successful
      expect(response.status).to eq(200)
      expect(assigns(:restaurant)).to eq(restaurant)
      expect(assigns(:items)).to eq(restaurant.items)
    end

    it 'returns 404 for invalid id' do
      get :show, params: { id: -1 }
      expect(response.status).to eq(404)
      expect(assigns(:restaurant)).to eq(nil)
      expect(assigns(:items)).to eq(nil)
    end
  end
end
