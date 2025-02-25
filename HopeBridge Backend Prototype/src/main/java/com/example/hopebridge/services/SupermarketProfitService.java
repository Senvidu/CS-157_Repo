package com.example.hopebridge.services;

import com.example.hopebridge.entities.Transaction;
import com.example.hopebridge.repos.TransactionRepository;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class SupermarketProfitService {

    private final TransactionRepository transactionRepository;

    public SupermarketProfitService(TransactionRepository transactionRepository) {
        this.transactionRepository = transactionRepository;
    }

    public double calculateProfit(Long supermarketId) {
        List<Transaction> transactions = transactionRepository.findBySupermarketId(supermarketId);
        return transactions.stream()
                .filter(Transaction::isUsedVoucher)
                .mapToDouble(Transaction::getPrice)
                .sum();
    }
}
