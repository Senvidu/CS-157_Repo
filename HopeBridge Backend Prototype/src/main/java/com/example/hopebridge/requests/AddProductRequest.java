package com.example.hopebridge.requests;

public class AddProductRequest {
    private String name;
    private Double price;
    private Boolean eligibleForVoucher;

    public AddProductRequest() {}
    public AddProductRequest(String name, Double price, Boolean eligibleForVoucher) {
        this.name = name; this.price = price; this.eligibleForVoucher = eligibleForVoucher;
    }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public Double getPrice() { return price; }
    public void setPrice(Double price) { this.price = price; }
    public Boolean getEligibleForVoucher() { return eligibleForVoucher; }
    public void setEligibleForVoucher(Boolean eligibleForVoucher) { this.eligibleForVoucher = eligibleForVoucher; }

    public static Builder builder() { return new Builder(); }
    public static class Builder {
        private String name; private Double price; private Boolean eligibleForVoucher;
        public Builder name(String name) { this.name = name; return this; }
        public Builder price(Double price) { this.price = price; return this; }
        public Builder eligibleForVoucher(Boolean eligibleForVoucher) { this.eligibleForVoucher = eligibleForVoucher; return this; }
        public AddProductRequest build() { return new AddProductRequest(name, price, eligibleForVoucher); }
    }
}
