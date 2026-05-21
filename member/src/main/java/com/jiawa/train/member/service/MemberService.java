package com.jiawa.train.member.service;

import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.util.ObjectUtil;
import cn.hutool.jwt.JWTUtil;
import com.jiawa.train.common.exception.BusinessException;
import com.jiawa.train.common.exception.BusinessExceptionEnum;
import com.jiawa.train.common.util.SnowUtil;
import com.jiawa.train.member.domain.Member;
import com.jiawa.train.member.domain.MemberExample;
import com.jiawa.train.member.mapper.MemberMapper;
import com.jiawa.train.member.req.MemberLoginReq;
import com.jiawa.train.member.req.MemberRegisterReq;
import com.jiawa.train.member.req.MemberSendCodeReq;
import com.jiawa.train.member.resp.MemberLoginResp;
import jakarta.annotation.Resource;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/*
* MemberMapper接口的服务类,实现count方法
* */
@Service
public class MemberService {
    private static final Logger LOG = LoggerFactory.getLogger(MemberService.class);

    @Resource
    private MemberMapper memberMapper;

    // 统计会员总数，调用MemberMapper的countByExample方法，传入null表示统计所有会员
    public int count() {
        return Math.toIntExact(memberMapper.countByExample(null));
    }

    // 注册方法，接收MemberRegisterReq对象，返回注册成功的会员ID
    public long register(MemberRegisterReq req) {
        String mobile = req.getMobile();
        Member memberBD = selectByMobile(mobile);

        // 如果手机号已存在，则认为手机号已注册，抛出异常
        if (ObjectUtil.isNotNull(memberBD)) {
            throw new BusinessException(BusinessExceptionEnum.MEMBER_MOBILE_EXIST);
        }

        Member member = new Member();
//        member.setId(System.currentTimeMillis());
        member.setId(SnowUtil.getSnowflakeNextId());
        member.setMobile(mobile);
        memberMapper.insert(member);
        return  member.getId();
    }
    public void sendCode(MemberSendCodeReq req) {
        String mobile = req.getMobile();
        Member memberBD = selectByMobile(mobile);

        // 如果已存在则认为手机号未注册，则插入记录
        if (ObjectUtil.isNull(memberBD)) {
            LOG.info("手机号不存在，插入一条记录");
            Member member = new Member();
//        member.setId(System.currentTimeMillis());
            member.setId(SnowUtil.getSnowflakeNextId());
            member.setMobile(mobile);
            memberMapper.insert(member);
        } else {
            LOG.info("手机号已存在，无需插入记录");
        }
        // 生成验证码
//        String code = RandomUtil.randomNumbers(4);
            String code = "8888";
        LOG.info("生成验证码: {}", code);
        // 保存短信记录表，手机号，短信验证码，有效期，是否已使用，业务类型，发送时间，使用时间
        LOG.info("保存短信记录");

        // 对接短信通道，发送短信
        LOG.info("对接短信通道");


    }

    public MemberLoginResp login(MemberLoginReq req) {
        String mobile = req.getMobile();
        String code = req.getCode();
        Member memberBD = selectByMobile(mobile);

        // 如果手机号不存在，则插入记录
        if (ObjectUtil.isNull(memberBD)) {
            throw new BusinessException(BusinessExceptionEnum.MEMBER_MOBILE_NOT_EXIST);
        }
        // 校验短信验证码
        if (!"8888".equals(code)) {
            throw new BusinessException(BusinessExceptionEnum.MEMBER_MOBILE_CODE_ERROR);
        }

        MemberLoginResp memberLoginResp = BeanUtil.copyProperties(memberBD, MemberLoginResp.class);
        Map<String, Object> map = BeanUtil.beanToMap(memberLoginResp);
        String key = "Jiawa12306";
        String token = JWTUtil.createToken(map, key.getBytes());
        memberLoginResp.setToken(token);
        return memberLoginResp;
    }

    private Member selectByMobile(String mobile) {
        MemberExample memberExample = new MemberExample();
        memberExample.createCriteria().andMobileEqualTo(mobile);
        List<Member> memberList = memberMapper.selectByExample(memberExample);
        if (CollUtil.isEmpty(memberList)) {
            return null;
        }else {
            return memberList.get(0);
        }
    }
}
