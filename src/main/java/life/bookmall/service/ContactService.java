package life.bookmall.service;

import life.bookmall.MallEnum.EnableStatus;
import life.bookmall.bean.Contact;
import life.bookmall.bean.ContactExample;
import life.bookmall.bean.User;
import life.bookmall.mapper.ContactMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Iterator;
import java.util.List;

/**
 * @Explain:   留言处理器
 * @Author: Cbuc
 * @Version: 1.0
 * @Date: 2019/11/11
 */
@Service
public class ContactService {

    @Autowired
    private ContactMapper contactMapper;

    @Autowired
    private UserService userService;

    public int doAdd(Contact contact) {
        return contactMapper.insertSelective(contact);
    }

    public List<Contact> getListByUserId(Long id) {
        ContactExample contactExample = new ContactExample();
        contactExample.createCriteria().andReceiverorEqualTo(id);
        contactExample.setOrderByClause("create_time desc");
        return contactMapper.selectByExample(contactExample);
    }

    public void fill(List<Contact> contacts) {
        Iterator<Contact> iterator = contacts.iterator();
        Contact contact;
        while (iterator.hasNext()) {
            contact = iterator.next();
            Long contactorId = contact.getContactor();
            User user = userService.queryDetail(contactorId);
            contact.setUser(user);
        }
    }

    public int queryCount(Long id) {
        ContactExample contactExample = new ContactExample();
        contactExample.createCriteria().andReceiverorEqualTo(id).andStatusNotEqualTo(EnableStatus.Disable.getStatus());
        return contactMapper.selectByExample(contactExample).size();
    }

    public int doUpdate(Contact contact) {
        ContactExample example = new ContactExample();
        example.createCriteria().andIdEqualTo(contact.getId());
        return contactMapper.updateByExampleSelective(contact, example);
    }
}
