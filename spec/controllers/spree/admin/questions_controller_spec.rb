RSpec.describe Spree::Admin::QuestionsController, type: :controller do
  stub_authorization!

  let!(:question) do
    create(:question, question_category: create(:question_category))
  end

  context '#index' do
    before { get :index }

    it 'renders the :index template' do
      expect(response).to render_template :index
    end
  end

  context '#new' do
    before { get :new }

    it 'assigns a new Spree::Question' do
      expect(assigns(:question)).to be_a_new Spree::Question
    end

    it 'renders the :new template' do
      expect(response).to render_template :new
    end
  end

  context '#edit' do
    before { get :edit, id: question }

    it 'assigns question to object' do
      expect(assigns(:question)).to eq question
    end

    it 'renders the :edit template' do
      expect(response).to render_template :edit
    end
  end

  describe '#create' do
    let(:attributes) do
      attributes_for(:question, question_category_id: 1)
    end

    context 'with valid params' do
      it 'creates a new Spree::Question' do
        expect {
          post :create, question: attributes
        }.to change(Spree::Question, :count).by(1)
      end

      it 'assigns a newly created question as @question' do
        post :create, question: attributes
        expect(assigns(:question)).to be_a Spree::Question
        expect(assigns(:question)).to be_persisted
      end
    end
  end

  context '#destroy' do
    it 'destroys the requested question' do
      expect {
        delete :destroy, id: question
      }.to change(Spree::Question, :count).by(-1)
    end

    it 'requires the :id parameter' do
      expect {
        delete :destroy
      }.to raise_error(ActionController::UrlGenerationError)
    end
  end
end
