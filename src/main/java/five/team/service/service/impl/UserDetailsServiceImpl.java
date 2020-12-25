package five.team.service.service.impl;

import five.team.service.entity.SecurityUser;
import five.team.service.entity.User;
import five.team.service.utils.MD5;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

@Service("userDetailsService")
public class UserDetailsServiceImpl implements UserDetailsService {

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        User user = new User();
        user.setUsername(username).setPassword(MD5.encrypt("111111"));
        SecurityUser securityUser = new SecurityUser(user);
        List<String> authorities = new ArrayList<>();
        authorities.add("vip1");
        securityUser.setPermissionValueList(authorities);
        return securityUser;
    }
}
