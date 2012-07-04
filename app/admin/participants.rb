# -*- coding: utf-8 -*-
ActiveAdmin.register Participant do
  menu label: 'Участники фестиваля'

  scope :all, :default => true
  scope :headliners
  scope :not_headliners

  filter :title

  index do
    id_column
    column "Фотография" do |p|
        link_to image_tag(p.logo.url(:thumb), alt: p.title), admin_participant_path(p)
    end
    column :title
    column :headliner
    column :description
    default_actions
  end

  form partial: 'form'

  show do
    attributes_table :title, :headliner, :updated_at

    panel 'Лого' do
      image_tag resource.logo.url(:medium)
    end

    panel 'Текст' do
      raw resource.description
    end
  end
end
