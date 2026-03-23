package com.example.hopebridge.requests;

public class PlaceOrderRequest {
    private Long userId;
    private Long productId;
    private boolean usedVoucher;

    public PlaceOrderRequest() {}
    public PlaceOrderRequest(Long userId, Long productId, boolean usedVoucher) {
        this.userId = userId;
        this.productId = productId;
        this.usedVoucher = usedVoucher;
    }

    public Long getUserId() { return userId; }
    public void setUserId(Long userId) { this.userId = userId; }
    public Long getProductId() { return productId; }
    public void setProductId(Long productId) { this.productId = productId; }
    public boolean isUsedVoucher() { return usedVoucher; }
    public void setUsedVoucher(boolean usedVoucher) { this.usedVoucher = usedVoucher; }

    public static Builder builder() { return new Builder(); }
    public static class Builder {
        private Long userId;
        private Long productId;
        private boolean usedVoucher;
        public Builder userId(Long userId) { this.userId = userId; return this; }
        public Builder productId(Long productId) { this.productId = productId; return this; }
        public Builder usedVoucher(boolean usedVoucher) { this.usedVoucher = usedVoucher; return this; }
        public PlaceOrderRequest build() { return new PlaceOrderRequest(userId, productId, usedVoucher); }
    }
}
