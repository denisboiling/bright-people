# -*- coding: utf-8 -*-
ActiveAdmin.register FestivalCategory, { :sort_order => :sorted } do
  menu label: "Категории", :parent => "Фото модуль"

  filter :title

  index do
    column :title
    column :position
    default_actions
  end

  form do |f|
    f.inputs "Основное" do
      f.input :title
      f.input :position
      f.input :path, as: :select, collection: (f.object.id ? FestivalCategory.top_level.where('id != ?', f.object.id) : FestivalCategory.top_level).map { |m| [m.title, m.id] }
    end
    f.buttons
  end

end
