package five.team.service.config;

import five.team.service.filter.TokenAuthenticationFilter;
import five.team.service.filter.TokenLoginFilter;
import five.team.service.security.DefaultPasswordEncoder;
import five.team.service.security.TokenLogoutHandler;
import five.team.service.security.TokenManager;
import five.team.service.security.UnauthorizedEntryPoint;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.authentication.ForwardAuthenticationSuccessHandler;
import org.springframework.stereotype.Controller;

@Configuration
@EnableWebSecurity
@EnableGlobalMethodSecurity(prePostEnabled = true)
public class SecurityConfig extends WebSecurityConfigurerAdapter {
    private UserDetailsService userDetailsService;
    //    private TokenManager tokenManager;
    private RedisTemplate redisTemplate;
    private DefaultPasswordEncoder defaultPasswordEncoder;

    public SecurityConfig(UserDetailsService userDetailsService, RedisTemplate redisTemplate, DefaultPasswordEncoder defaultPasswordEncoder) {
        this.userDetailsService = userDetailsService;
//        this.tokenManager = tokenManager;
        this.redisTemplate = redisTemplate;
        this.defaultPasswordEncoder = defaultPasswordEncoder;
    }

    @Override
    protected void configure(HttpSecurity http) throws Exception {
//        http.exceptionHandling()
//                .authenticationEntryPoint(new UnauthorizedEntryPoint())
//                .and().csrf().disable()
//                .authorizeRequests().anyRequest().authenticated()
//                .and().logout().logoutSuccessUrl("/")
//                .addLogoutHandler(new TokenLogoutHandler(tokenManager, redisTemplate))
//                .and().formLogin().successForwardUrl("/main")
//                .and()
//                .addFilter(new TokenLoginFilter(authenticationManager(), tokenManager, redisTemplate))
//                .addFilter(new TokenAuthenticationFilter(authenticationManager(), tokenManager, redisTemplate));
        http.headers().frameOptions().disable();
//        http.authorizeRequests().antMatchers("/acl-permission/menu/list/**").hasAnyRole("AUTH");
        http.authorizeRequests().antMatchers("/toLogin", "/", "/login").permitAll();
        http.authorizeRequests().anyRequest().authenticated();
        http.csrf().disable();
        http.formLogin()
                .loginPage("/toLogin")
                .loginProcessingUrl("/login").successForwardUrl("/main")
                .failureForwardUrl("/toLogin");
        http.logout().logoutSuccessUrl("/toLogin");
        http.rememberMe();

    }

    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
//        auth.inMemoryAuthentication().passwordEncoder(defaultPasswordEncoder)
//                .withUser("user").password(defaultPasswordEncoder.encode("111111")).roles("vip1", "vip2")
//                .and().withUser("tom").password(defaultPasswordEncoder.encode("111111")).roles("vip1");
        auth.userDetailsService(userDetailsService).passwordEncoder(defaultPasswordEncoder);

    }

    @Override
    public void configure(WebSecurity web) throws Exception {
        web.ignoring().antMatchers("/**.css","/**.js","/**.png","/imgs/**","/**.jpg");
        //        web.ignoring().antMatchers("/", "/index", "/login/**", "/register", "/logout", "/toRegister");
    }
}
