package org.example.demospringboot.service;

import org.example.demospringboot.entities.Category;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;
import java.util.Optional;

public interface ICategoryService {
    List<Category> findByCategoryNameContaining(String name);

    Page<Category> findByCategoryNameContaining(String name, Pageable pageable);

    Optional<Category> findById(Integer integer);

    <S extends Category> S save(S entity);

    List<Category> findAll();

    void deleteById(Integer integer);
}
