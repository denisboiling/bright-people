#= require jquery
#= require jquery-ui
#= require jquery_ujs
#= require jquery.cookie
#= require slides.min.jquery
#= require jquery.raty.min
#= require jquery.pikachoose
#= require jquery.jcarousel.min
#= require jquery.countdown
#= require_directory .

$ ->
  window.setup_dialogs()
  window.setup_email_dialog()
  window.setup_activities_list()
  window.setup_activities_approval()
  window.add_comment()
  window.setup_favourite_button()
  window.setup_slider()
  window.setup_raty()
  window.setup_prev_next_expert_arrows()
  window.setup_ajax_articles_loading()
  window.setup_load_activity_comments()
  window.setup_expert_tabs()
  window.setup_new_participant_form_button()
  window.setup_ajax_interviews_loading()
  window.setup_ajax_news_loading()
  window.setup_ajax_contest_memberships_loading()
  window.setup_new_membership_creation()
  window.setup_profile_ajax()
  window.setup_logout_link()
