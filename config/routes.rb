Rails.application.routes.draw do
  scope :api do
    get    'binders/:binder_key'                      => 'api/binders#index'
    get    'binders/:binder_key'                      => 'api/binders#show'
    get    'binders/:binder_key/reports'              => 'api/reports#index'
    get    'binders/:binder_key/reports/:report_id'   => 'api/reports#show'
    get    '@:user_id/:binder_key/reports'            => 'api/users/reports#index'
    get    '@:user_id/:binder_key/reports/:report_id' => 'api/users/reports#show'
    put    '@:user_id/:binder_key/reports/:report_id' => 'api/users/reports#update'
  end

  scope :admins do
    get    ''                                         => 'admins#index'

    get    'binders/'                                 => 'admins/binders#index'
    post   'binders/'                                 => 'admins/binders#create'
    get    'binders/:binder_key'                      => 'admins/binders#show'
    put    'binders/:binder_key'                      => 'admins/binders#update'
    delete 'binders/:binder_key'                      => 'admins/binders#destroy'

    post   'binders/:binder_key/histories'            => 'admins/histories#create'
    delete 'binders/:binder_key/histories'            => 'admins/histories#destroy'

    get    'binders/:binder_key/reports'              => 'admins/reports#index'
    get    'binders/:binder_key/reports/:report_id'   => 'admins/reports#show'

    get    'users'                                    => 'admins/users#index'
    get    '@:user_id'                                => 'admins/users#show'
    get    '@:user_id/:binder_key/reports'            => 'admins/users/report#index'
  end
end
