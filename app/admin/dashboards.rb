ActiveAdmin::Dashboards.build do

#Within DashboardController
      def index
        if defined? CanCan then
            authorize! :index, self.class.name
        end
        @dashboard_sections = find_sections
        render_or_default 'index'
      end

section "Recent Applicants" , :priority => 1 , :if => proc{ cannot?(:manage, Applicant) } do
    table_for Applicant.where(:status => "Approved").order("created_at desc").limit(10) do
      column :id do |applicant|
        link_to applicant.id, admin_applicant_path(applicant)
     end
      column :name do |applicant|
        link_to applicant.first_name, admin_applicant_path(applicant)
      end
      column :created_at
      column :status do |applicant|
        strong {applicant.status}
      end
    end
    strong { link_to "View All Applicants", admin_applicants_path }
  end



section "Statistics" , :priority => 1 , :if => proc{ can?(:manage, Applicant) } do  
  div  :class => 'stat' do
    render 'statistics'
  end
end

section "Applications", :priority => 2, :if => proc{ can?(:manage, Applicant) } do
  # table_for Applicant.limit(1) do
    # column :all do |applicant|
          # strong {Applicant.count}
    # end
    # column :submitted do |applicant|
          # strong { Applicant.where(:status => "Submitted").count}
    # end
    # column :approved do |applicant|
          # strong { Applicant.where(:status => "Approved").count}
    # end
    # column :rejected do |applicant|
          # strong { Applicant.where(:status => "Rejected").count}
    # end
  # end
  div do
    render 'stats'
  end
end

section "Recent Applicants" , :priority => 3 , :if => proc{ can?(:manage, Applicant) } do
    table_for Applicant.order("created_at desc").limit(10) do
      column :id do |applicant|
        link_to applicant.id, admin_applicant_path(applicant)
     end
      column :name do |applicant|
        link_to applicant.first_name, admin_applicant_path(applicant)
      end
      column :created_at
      column :status do |applicant|
        strong {applicant.status}
      end
    end
    strong { link_to "View All Applicants", admin_applicants_path }
  end

  # Define your dashboard sections here. Each block will be
  # rendered on the dashboard in the context of the view. So just
  # return the content which you would like to display.
  
  # == Simple Dashboard Section
  # Here is an example of a simple dashboard section
  #
  #   section "Recent Posts" do
  #     ul do
  #       Post.recent(5).collect do |post|
  #         li link_to(post.title, admin_post_path(post))
  #       end
  #     end
  #   end
  
  # == Render Partial Section
  # The block is rendered within the context of the view, so you can
  # easily render a partial rather than build content in ruby.
  #
  #   section "Recent Posts" do
  #     div do
  #       render 'recent_posts' # => this will render /app/views/admin/dashboard/_recent_posts.html.erb
  #     end
  #   end
  
  # == Section Ordering
  # The dashboard sections are ordered by a given priority from top left to
  # bottom right. The default priority is 10. By giving a section numerically lower
  # priority it will be sorted higher. For example:
  #
  #   section "Recent Posts", :priority => 10
  #   section "Recent User", :priority => 1
  #
  # Will render the "Recent Users" then the "Recent Posts" sections on the dashboard.
  
  # == Conditionally Display
  # Provide a method name or Proc object to conditionally render a section at run time.
  #
  # section "Membership Summary", :if => :memberships_enabled?
  # section "Membership Summary", :if => Proc.new { current_admin_user.account.memberships.any? }

end
