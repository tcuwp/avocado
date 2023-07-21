module FlashesHelper
  def user_facing_flashes
    flash.to_hash.slice("alert", "error", "notice", "success")
  end

  def user_facing_flash_classes
    {
      alert: "flash-alert",
      error: "flash-error",
      notice: "flash-notice",
      success: "flash-success"
    }
  end
end
