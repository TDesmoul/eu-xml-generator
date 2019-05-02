class AnnualSalesUpdateFeedback < ApplicationRecord
  serialize :missing_on_ftp, Array
  serialize :absent_in_csv, Array
  serialize :missing_countries, Hash
end
