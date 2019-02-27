package com.book.service;

import com.book.dao.LendDao;
import com.book.domain.Lend;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;

@Service
public class LendService {
    private LendDao lendDao;

    @Autowired
    public void setLendDao(LendDao lendDao) {
        this.lendDao = lendDao;
    }

    public boolean bookReturn(long bookId){
        return lendDao.bookReturnOne(bookId)>0 && lendDao.bookReturnTwo(bookId)>0;
    }

    public boolean bookLend(long bookId,int readerId,float price){
        if(lendDao.bookLendThree(price,readerId)<=0)
            return false;
        else if(lendDao.bookLendTwo(bookId)<=0)
            return false;
        else if(lendDao.bookLendOne(bookId,readerId)<=0)
            return false;
        else return true;

//        return lendDao.bookLendOne(bookId,readerId)>0 && lendDao.bookLendTwo(bookId)>0 && lendDao.bookLendThree(price,readerId)>0;
//        return  lendDao.bookLendTwo(bookId)>0;
    }

    public ArrayList<Lend> lendList(){
        return lendDao.lendList();
    }
    public ArrayList<Lend> myLendList(int readerId){
        return lendDao.myLendList(readerId);
    }
    public boolean deleteLend(int sernum){return lendDao.deleteLend(sernum) > 0;}

}
