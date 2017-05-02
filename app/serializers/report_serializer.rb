class ReportSerializer < ActiveModel::Serializer
  attributes :body, :newer_body, :older_body
end