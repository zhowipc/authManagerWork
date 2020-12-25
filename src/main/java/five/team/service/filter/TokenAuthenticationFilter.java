package five.team.service.filter;

import five.team.service.entity.R;
import five.team.service.security.TokenManager;
import five.team.service.utils.ResponseUtil;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.www.BasicAuthenticationFilter;
import org.springframework.util.StringUtils;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

public class TokenAuthenticationFilter extends BasicAuthenticationFilter {
    private TokenManager tokenManager;
    private RedisTemplate redisTemplate;


    public TokenAuthenticationFilter(AuthenticationManager authenticationManager, TokenManager tokenManager, RedisTemplate redisTemplate) {
        super(authenticationManager);
        this.tokenManager = tokenManager;
        this.redisTemplate = redisTemplate;
    }

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain chain) throws IOException, ServletException {
        logger.info("=====================" + request.getRequestURI());

        UsernamePasswordAuthenticationToken authentication = null;
        authentication = getAuthentication(request);
        if (authentication != null) {
            SecurityContextHolder.getContext().setAuthentication(authentication);
        }else {
            ResponseUtil.out(response, R.error());
        }
        chain.doFilter(request, response);
    }

    private UsernamePasswordAuthenticationToken getAuthentication(HttpServletRequest request) {
        String token = request.getHeader("token");
        if (token != null && "".equals(token.trim())) {
            String username = tokenManager.getUserFromToken(token);
            List<String> permissionValueList = (List<String>) redisTemplate.opsForValue().get(username);
            Collection<GrantedAuthority> authorities = new ArrayList<>();

            for (String permissionValue : permissionValueList) {
                if (!StringUtils.isEmpty(permissionValue)) {
                    SimpleGrantedAuthority authority = new SimpleGrantedAuthority(permissionValue);
                    authorities.add(authority);
                }
            }
            if (!StringUtils.isEmpty(username)) {
                return new UsernamePasswordAuthenticationToken(username, token, authorities);
            }
        }
        return null;
    }
}
