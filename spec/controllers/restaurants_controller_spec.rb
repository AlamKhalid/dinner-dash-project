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
    end

    context 'with non-admin users' do
      before { allow(controller).to receive(:current_user).and_return(user) }

      it 'redirects' do
        get :new
        expect(response.status).to eq(302)
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
end
