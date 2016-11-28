Spree::Backend::Config.configure do |config|
  config.menu_items << config.class::MenuItem.new(
    [:questions, :question_categories],
    'book',
    label: :faq,
    url: :admin_questions_path,
    condition: -> { can? :admin, Spree::QuestionCategory },
    partial: "spree/admin/shared/faq_sub_menu"
  )
end
