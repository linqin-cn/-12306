package com.jiawa.train.member.service;

import cn.hutool.core.collection.CollUtil;
import com.jiawa.train.member.domain.Member;
import com.jiawa.train.member.domain.MemberExample;
import com.jiawa.train.member.mapper.MemberMapper;
import com.jiawa.train.member.req.MemberRegisterReq;
import jakarta.annotation.Resource;
import org.springframework.stereotype.Service;

import java.util.List;

/*
* MemberMapper接口的服务类,实现count方法
* */
@Service
public class MemberService {
    @Resource
    private MemberMapper memberMapper;

    // 统计会员总数，调用MemberMapper的countByExample方法，传入null表示统计所有会员
    public int count() {
        return Math.toIntExact(memberMapper.countByExample(null));
    }

    // 注册方法，接收MemberRegisterReq对象，返回注册成功的会员ID
    public long register(MemberRegisterReq req) {
        String mobile = req.getMobile();
        MemberExample memberExample = new MemberExample();
        memberExample.createCriteria().andMobileEqualTo(mobile);
        List<Member> memberList = memberMapper.selectByExample(memberExample);

        // 如果已存在则认为手机号已注册，阻止重复注册
        if (CollUtil.isNotEmpty(memberList)) {
            throw new RuntimeException("手机号已注册");
        }

        Member member = new Member();
        member.setId(System.currentTimeMillis());
        member.setMobile(mobile);
        memberMapper.insert(member);
        return  member.getId();
    }
}
