package five.team.service.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import five.team.service.dtree.CheckArr;
import five.team.service.dtree.DTree;
import five.team.service.dtree.Node;
import five.team.service.entity.AclPermission;
import five.team.service.entity.AclRolePermission;
import five.team.service.mapper.AclPermissionMapper;
import five.team.service.service.AclPermissionService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import five.team.service.service.AclRolePermissionService;
import five.team.service.service.AclRoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

/**
 * <p>
 * 权限 服务实现类
 * </p>
 *
 * @author testjava
 * @since 2020-12-27
 */
@Service
@Transactional
public class AclPermissionServiceImpl extends ServiceImpl<AclPermissionMapper, AclPermission> implements AclPermissionService {
    @Autowired
    private AclRolePermissionService rolePermissionService;

    @Autowired
    private AclRoleService roleService;

    //获取全部菜单
    private List<DTree> getAllPermissionMenu() {
        List<DTree> aclPermissions = new ArrayList<>();
        List<AclPermission> permissions = baseMapper.selectList(null);

        List<DTree> dTrees = new ArrayList<>();
        for (AclPermission permission : permissions) {
            DTree dTree = new DTree();
            dTree.setId(permission.getId());
            dTree.setParentId(permission.getPid());
            dTree.setTitle(permission.getTitle());
            dTrees.add(dTree);
        }
        dTrees.forEach(it -> {
            if (it.getParentId().equals("0")) {
                getPermissionChildren(it, dTrees);
                it.setCheckArr(Arrays.asList(new CheckArr("0", "0")));
                aclPermissions.add(it);
            }
        });


        return aclPermissions;
    }

    //根据roleId获取菜单
    @Override
    public List<DTree> getPermissionMenuByRoleId(String roleId) {

        //获取角色拥有的菜单id
        List<String> hasMenuByRoleId = getHasMenuByRoleId(roleId);


        List<DTree> aclPermissions = new ArrayList<>();
        QueryWrapper<AclPermission> aclPermissionQueryWrapper = new QueryWrapper<>();
//        aclPermissionQueryWrapper.ne("type", 1);
        List<AclPermission> permissions = baseMapper.selectList(aclPermissionQueryWrapper);

        List<DTree> dTrees = new ArrayList<>();
        for (AclPermission permission : permissions) {
            DTree dTree = new DTree();
            dTree.setId(permission.getId());
            dTree.setParentId(permission.getPid());
            dTree.setTitle(permission.getTitle());
            dTrees.add(dTree);
        }
        dTrees.forEach(it -> {
            if (it.getParentId().equals("0")) {
                getPermissionChildren(it, dTrees, hasMenuByRoleId);
                boolean contains = hasMenuByRoleId.contains(it.getId());
                if (contains) {
                    it.setCheckArr(Arrays.asList(new CheckArr("0", "1")));
                } else {
                    it.setCheckArr(Arrays.asList(new CheckArr("0", "0")));
                }
                aclPermissions.add(it);
            }
        });
        return aclPermissions;
    }

    @Override
    public void setAuthForRole(String roleId, List<String> permissionIds) {
        //删除原先的菜单联系
        QueryWrapper<AclRolePermission> aclRolePermissionQueryWrapper = new QueryWrapper<>();
        aclRolePermissionQueryWrapper.eq("role_id", roleId);
        aclRolePermissionQueryWrapper.select("id");
        List<AclRolePermission> list = rolePermissionService.list(aclRolePermissionQueryWrapper);
        List<String> collect = list.stream().map(i -> i.getId()).collect(Collectors.toList());
        if (collect.size() != 0)
            rolePermissionService.removeByIds(collect);
        for (String permissionId : permissionIds) {
            rolePermissionService.save(new AclRolePermission().setRoleId(roleId).setPermissionId(permissionId));
        }

    }

    @Override
    public List<String> getCheckedIds(String roleId) {
        QueryWrapper<AclRolePermission> aclRolePermissionQueryWrapper = new QueryWrapper<>();
        aclRolePermissionQueryWrapper.select("permission_id");
        aclRolePermissionQueryWrapper.eq("role_id", roleId);
        List<AclRolePermission> list = rolePermissionService.list(aclRolePermissionQueryWrapper);
        List<String> collect = list.stream().map(i -> i.getPermissionId()).collect(Collectors.toList());
        return collect;
    }

    @Override
    public void addPermission(Node node) {
        AclPermission aclPermission = new AclPermission();
        aclPermission.setPath(node.getPath())
                .setPid(node.getParentId())
                .setTitle(node.getAddNodeName())
                .setPermissionValue(node.getPermissionValue())
                .setType(Integer.parseInt(node.getType()));

        baseMapper.insert(aclPermission);
    }

    @Override
    public void editPermission(Node node) {
        AclPermission aclPermission = new AclPermission();
        aclPermission.setPath(node.getPath())
                .setPid(node.getParentId())
                .setTitle(node.getAddNodeName())
                .setPermissionValue(node.getPermissionValue())
                .setId(node.getNodeId())
                .setType(Integer.parseInt(node.getType()));
        baseMapper.updateById(aclPermission);
    }

    @Override
    public void deletePermission(Node node) {
        QueryWrapper<AclPermission> wrapper = new QueryWrapper<>();
        wrapper.eq("pid", node.getNodeId()).select("id");
        List<AclPermission> aclPermissions = baseMapper.selectList(wrapper);
        List<String> collect = aclPermissions.stream().map(it -> it.getId()).collect(Collectors.toList());

        deletePermissionChildren(collect);

        QueryWrapper<AclRolePermission> aclRolePermissionQueryWrapper = new QueryWrapper<>();
        aclRolePermissionQueryWrapper.eq("permission_id", node.getNodeId()).select("id");
        rolePermissionService.remove(aclRolePermissionQueryWrapper);

        baseMapper.deleteById(node.getNodeId());
    }

    //将获取到的list型数据转换成tree型
    private List<DTree> formatterTree(List<AclPermission> sources) {
        List<DTree> dTrees = new ArrayList<>();
        if (sources.size() != 0) {
            for (AclPermission aclPermission : sources) {
                DTree dTree = new DTree();
                dTree.setCheckArr(Arrays.asList(new CheckArr("0", "0")));
                dTree.setTitle(aclPermission.getTitle())
                        .setParentId(aclPermission.getPid())
                        .setSpread(true)
                        .setId(aclPermission.getId())
                        .setBasicData(aclPermission.getPath());
                dTrees.add(dTree);
            }
        }
        List<DTree> result = new ArrayList<>();

        dTrees.forEach(it -> {
            if (it.getParentId().equals("0")) {
                getPermissionChildren(it, dTrees);
                it.setCheckArr(Arrays.asList(new CheckArr("0", "0")));
                result.add(it);
            }
        });
        return result;
    }

    //获取全部菜单 不区分角色
    @Override
    public List<DTree> getMenu() {
        QueryWrapper<AclPermission> aclPermissionQueryWrapper = new QueryWrapper<>();
        aclPermissionQueryWrapper.ge("type", 0);
        aclPermissionQueryWrapper.le("type", 1);

        List<AclPermission> aclPermissions = baseMapper.selectList(aclPermissionQueryWrapper);
        List<DTree> dTrees = formatterTree(aclPermissions);

        return dTrees;
    }

    //根据用户名获取有关菜单
    private List<AclPermission> getPermissionByUsername(String username) {
        List<AclPermission> result = new ArrayList<>();

        List<String> roleIdByUserName = roleService.findRoleIdByUserName(username);
        for (String roleId : roleIdByUserName) {
            List<AclRolePermission> permissionsIdByRoleId = roleService.findPermissionsIdByRoleId(roleId);
            for (AclRolePermission aclRolePermission : permissionsIdByRoleId) {
                AclPermission permissionByPermissionId = roleService.findPermissionByPermissionId(aclRolePermission.getPermissionId());
                if (permissionByPermissionId.getType() == 0 || permissionByPermissionId.getType() == 1) {
//                    || result.contains(permissionByPermissionId)
                    int flag = 1;
                    for (AclPermission aclPermission : result) {
                        if (aclPermission.getId().equals(permissionByPermissionId.getId())) {
                            flag = 0;
                            break;
                        }
                    }
                    if (flag == 1)
                        result.add(permissionByPermissionId);

                }

            }
        }
        System.out.println("==================AclPermissionServiceImpl.getPermissionByUsername");
        System.out.println(result);
        return result;
    }

    @Override
    public List<DTree> getMenuCont(String name) {
        List<AclPermission> aclPermissions = getPermissionByUsername(name);
        List<DTree> dTrees = formatterTree(aclPermissions);
        return dTrees;
    }

    private void deletePermissionChildren(List<String> ids) {
        if (ids.size() != 0) {
            for (String id : ids) {
                QueryWrapper<AclPermission> wrapper = new QueryWrapper<>();
                wrapper.eq("pid", id).select("id");

                List<AclPermission> aclPermissions = baseMapper.selectList(wrapper);
                List<String> collect = aclPermissions.stream().map(it -> it.getId()).collect(Collectors.toList());
                if (collect.size() != 0) {
                    deletePermissionChildren(collect);
                }
                QueryWrapper<AclRolePermission> aclRolePermissionQueryWrapper = new QueryWrapper<>();
                aclRolePermissionQueryWrapper.eq("permission_id", id).select("id");
                rolePermissionService.remove(aclRolePermissionQueryWrapper);
                baseMapper.deleteById(id);
            }

        }
    }

    //获取role拥有的菜单id
    private List<String> getHasMenuByRoleId(String roleId) {
        QueryWrapper<AclRolePermission> aclRolePermissionQueryWrapper = new QueryWrapper<>();
        aclRolePermissionQueryWrapper.eq("role_id", roleId);
        aclRolePermissionQueryWrapper.select("permission_id");
        List<AclRolePermission> list = rolePermissionService.list(aclRolePermissionQueryWrapper);
        List<String> collect = list.stream().map(i -> i.getPermissionId()).collect(Collectors.toList());
        return collect;
    }


    private void getPermissionChildren(DTree target, List<DTree> sources, List<String> hasMenuByRoleId) {
        List<DTree> childrenList = new ArrayList<>();
        if (target != null)
            for (DTree source : sources) {
                if (source.getParentId().equals(target.getId())) {
                    boolean contains = hasMenuByRoleId.contains(source.getId());
                    if (contains) {
                        source.setCheckArr(Arrays.asList(new CheckArr("0", "1")));
                    } else {
                        source.setCheckArr(Arrays.asList(new CheckArr("0", "0")));
                    }
                    childrenList.add(source);
                }
            }
        if (childrenList.size() != 0)
            for (DTree aclPermission : childrenList) {
                if (aclPermission != null && !StringUtils.isEmpty(aclPermission.getParentId())) {
                    getPermissionChildren(aclPermission, sources, hasMenuByRoleId);
                }
            }
        target.setChildren(childrenList);
    }

    private void getPermissionChildren(DTree target, List<DTree> sources) {
        List<DTree> childrenList = new ArrayList<>();
        if (target != null)
            for (DTree source : sources) {
                if (source.getParentId().equals(target.getId())) {
                    source.setCheckArr(Arrays.asList(new CheckArr("0", "0")));
                    childrenList.add(source);
                }
            }
        if (childrenList.size() != 0)
            for (DTree aclPermission : childrenList) {
                if (aclPermission != null && !StringUtils.isEmpty(aclPermission.getParentId())) {
                    getPermissionChildren(aclPermission, sources);
                }
            }
        target.setChildren(childrenList);
    }
}
