module DocumentsHelper
  def status_to_string status
    if status == 0
      "Draft"
    elsif status == 1
      "For review"
    elsif status == 2
      "For approval"
    elsif status == 3
      "Effective"
    else
      "Unknown"
    end
  end

  def approval_status_to_string status, updated_at
    if status == 0
      'Pending'
    elsif status == 1
      'Approved(' + updated_at.to_s + ')'
    elsif status == 2
      'Declined(' + updated_at.to_s + ')'
    elsif status == 3
      'Canceled'
    else
      'Unknown'
    end
  end

  def review_status_to_string status, updated_at
    if status == 0
      'Pending'
    elsif status == 1
      updated_at.to_s
    else
      'Unknown'
    end
  end

  def trainee_status_to_string status, updated_at
    if status == 0
      'Pending'
    elsif status == 1
      updated_at.to_s
    else
      'Unknown'
    end
  end

  def get_document_version document
    "#{document.major_version}.#{document.minor_version}"
  end

  def get_effective_document_version document
    "#{document.major_version}.0"
  end

end
