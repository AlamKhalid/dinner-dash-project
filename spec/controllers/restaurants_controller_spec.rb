# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RestaurantsController, type: :controller do
  let(:user) { FactoryBot.create :user }
  let(:admin) { FactoryBot.create :admin }
  let(:restaurant) { FactoryBot.create :restaurant }
  let(:category) { FactoryBot.create :category, name: 'Cat300' }
  let(:item) { FactoryBot.create :item, restaurant: restaurant }
  let(:item2) { FactoryBot.create :item2, name: 'Item222', restaurant: restaurant, categories: [category] }
  let(:order) { FactoryBot.create :cart_order, type: 'Order', user: user, restaurant: restaurant, status: 'ordered' }
  let(:order_item) { FactoryBot.create :cart_order_item, cart_order: order, item: item, type: 'OrderItem' }

  describe '#GET index' do
    it 'returns a successful response with index template and restaurants' do
      get :index
      expect(response).to be_successful
      expect(response.status).to eq(200)
      expect(response).to render_template('index')
      expect(assigns(:restaurants)).to eq([restaurant])
    end
  end

  describe '#GET new' do
    context 'with unauthenticated users' do
      before { allow(controller).to receive(:current_user).and_return(nil) }

      it 'redirects to root path' do
        get :new
        expect(controller).to use_before_action(:authorize_admin)
        expect(response.status).to eq(302)
        expect(response).to redirect_to(root_path)
      end
    end

    context 'with non-admin users' do
      before { allow(controller).to receive(:current_user).and_return(user) }

      it 'redirects to root path' do
        get :new
        expect(controller).to use_before_action(:authorize_admin)
        expect(response.status).to eq(302)
        expect(response).to redirect_to(root_path)
      end
    end

    context 'with admin users' do
      before { allow(controller).to receive(:current_user).and_return(admin) }

      it 'returns successfull with new template and restaurant for admin' do
        get :new
        expect(controller).to use_before_action(:authorize_admin)
        expect(response).to be_successful
        expect(response.status).to eq(200)
        expect(response).to render_template('new')
        expect(assigns(:restaurant)).to be_a_new(Restaurant)
      end
    end
  end

  describe '#POST create' do
    context 'with unauthenticated users' do
      before { allow(controller).to receive(:current_user).and_return(nil) }

      it 'redirects to root path' do
        post :create
        expect(controller).to use_before_action(:authorize_admin)
        expect(response.status).to eq(302)
        expect(response).to redirect_to(root_path)
      end
    end

    context 'with non-admin users' do
      before { allow(controller).to receive(:current_user).and_return(user) }

      it 'redirects to root path' do
        post :create
        expect(controller).to use_before_action(:authorize_admin)
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
        expect(controller).to use_before_action(:authorize_admin)
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

  describe '#GET edit' do
    context 'with unauthenticated users' do
      before { allow(controller).to receive(:current_user).and_return(nil) }

      it 'redirects to root path' do
        get :edit, params: { id: restaurant.id }
        expect(controller).to use_before_action(:authorize_admin)
        expect(controller).to use_before_action(:find_restaurant)
        expect(response.status).to eq(302)
        expect(response).to redirect_to(root_path)
      end
    end

    context 'with non-admin users' do
      before { allow(controller).to receive(:current_user).and_return(user) }

      it 'redirects to root path' do
        get :edit, params: { id: restaurant.id }
        expect(controller).to use_before_action(:authorize_admin)
        expect(controller).to use_before_action(:find_restaurant)
        expect(response.status).to eq(302)
        expect(response).to redirect_to(root_path)
      end
    end

    context 'with admin users' do
      before { allow(controller).to receive(:current_user).and_return(admin) }

      it 'returns successful' do
        get :edit, params: { id: restaurant.id }
        expect(controller).to use_before_action(:authorize_admin)
        expect(controller).to use_before_action(:find_restaurant)
        expect(response).to be_successful
        expect(response.status).to eq(200)
        expect(response).to render_template('edit')
        expect(assigns(:restaurant)).to be_a(Restaurant)
      end
    end
  end

  describe '#PUT update' do
    let(:updated_params) do
      {
        id: restaurant.id,
        restaurant: {
          name: 'Ranchers',
          location: 'Islamabad'
        },
        format: 'js'
      }
    end

    context 'with unauthenticated users' do
      before { allow(controller).to receive(:current_user).and_return(nil) }

      it 'redirects to root path' do
        put :update, params: updated_params
        expect(controller).to use_before_action(:authorize_admin)
        expect(controller).to use_before_action(:find_restaurant)
        expect(response.status).to eq(302)
        expect(response).to redirect_to(root_path)
      end
    end

    context 'with non-admin users' do
      before { allow(controller).to receive(:current_user).and_return(user) }

      it 'redirects to root path' do
        put :update, params: updated_params
        expect(controller).to use_before_action(:authorize_admin)
        expect(controller).to use_before_action(:find_restaurant)
        expect(response.status).to eq(302)
        expect(response).to redirect_to(root_path)
      end
    end

    context 'with admin users' do
      before { allow(controller).to receive(:current_user).and_return(admin) }

      it 'returns successful with update template and correct variables' do
        put :update, params: updated_params
        expect(controller).to use_before_action(:authorize_admin)
        expect(controller).to use_before_action(:find_restaurant)
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
        updated_params[:id] = -1
        put :update, params: updated_params
        expect(controller).to use_before_action(:authorize_admin)
        expect(controller).to use_before_action(:find_restaurant)
        expect(response.status).to eq(404)
      end

      it 'populates error messages for invalid data' do
        updated_params[:restaurant][:name] = nil
        put :update, params: updated_params
        expect(controller).to use_before_action(:authorize_admin)
        expect(controller).to use_before_action(:find_restaurant)
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

  describe '#PUT category_filter' do
    let(:valid_params) do
      {
        restaurant_id: item.restaurant.id,
        category_name: item.categories[0].name,
        format: 'js'
      }
    end

    context 'when valid' do
      it 'returns items with specific category' do
        put :category_filter, params: valid_params
        expect(response).to be_successful
        expect(response.status).to eq(200)
        expect(assigns(:items)).to eq([item])
        expect(assigns(:items)).not_to include(item2)
      end

      it 'returns popular itmes' do
        order.save
        order_item.save
        valid_params[:category_name] = 'popular'
        put :category_filter, params: valid_params
        expect(response).to be_successful
        expect(response.status).to eq(200)
        expect(assigns(:items)).to eq([item])
        expect(assigns(:items)).not_to include(item2)
      end

      it 'returns all items for all category' do
        valid_params[:category_name] = 'all'
        put :category_filter, params: valid_params
        expect(response).to be_successful
        expect(response.status).to eq(200)
        expect(assigns(:items)).to eq(restaurant.items)
        expect(assigns(:items)).to include(item)
      end

      it 'returns empty items array for non-existent category' do
        valid_params[:category_name] = 'nil'
        put :category_filter, params: valid_params
        expect(response).to be_successful
        expect(response.status).to eq(200)
        expect(assigns(:items)).to eq([])
        expect(assigns(:items)).not_to include(item)
        expect(assigns(:items)).not_to include(item2)
      end
    end
  end

  describe '#GET show' do
    context 'when id is valid' do
      it 'returns successful response and sets restaurant and items' do
        get :show, params: { id: restaurant.id }
        expect(controller).to use_before_action(:find_restaurant)
        expect(response).to be_successful
        expect(response.status).to eq(200)
        expect(assigns(:restaurant)).to eq(restaurant)
        expect(assigns(:items)).to eq(restaurant.items)
      end
    end

    context 'when id is invalid' do
      it 'returns 404 for invalid id' do
        get :show, params: { id: -1 }
        expect(controller).to use_before_action(:find_restaurant)
        expect(response.status).to eq(404)
        expect(assigns(:restaurant)).to eq(nil)
        expect(assigns(:items)).to eq(nil)
      end
    end
  end
end
