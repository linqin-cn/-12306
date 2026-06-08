package com.jiawa.train.batch.mapper;

import com.jiawa.train.batch.domain.Member;
import com.jiawa.train.batch.domain.MemberExample;
import org.apache.ibatis.annotations.Param;

import java.util.List;

// MemberMapper 接口不需要手动编写实现类，MyBatis 会通过动态代理自动生成实现
public interface MemberMapper {
    long countByExample(MemberExample example);

    int deleteByExample(MemberExample example);

    int deleteByPrimaryKey(Long id);

    int insert(Member record);

    int insertSelective(Member record);

    List<Member> selectByExample(MemberExample example);

    Member selectByPrimaryKey(Long id);

    int updateByExampleSelective(@Param("record") Member record, @Param("example") MemberExample example);

    int updateByExample(@Param("record") Member record, @Param("example") MemberExample example);

    int updateByPrimaryKeySelective(Member record);

    int updateByPrimaryKey(Member record);
}
