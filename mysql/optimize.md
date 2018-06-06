###
mysql优化可分解为三个层面：

    1.硬件配置
    
    2.配置文件
    
    3.语句及索引

###

日志分析工具
    mysqldumpslow

慢查询工具
    pt-query-digest 
    mysql > show variables like '%query%' ;
    mysql > show variables like '%slow_query_log%' ;


###

3.语句及索引

    1.查询次数多且每次查询时间长的sql
          pt-query-digest 分析的前面几个查询

    2.IO大的sql
          pt-query-digest 分析中 Rows examine项 注：扫描的行数

    3.未命中的索引
          pt-query-digest 分析中 Rows examine > Rows Send = 说明命中率不高

    B. explain查询和分析SQL执行计划
    mysql> explain select * from user;
    +----+-------------+-------+------------+------+---------------+------+---------+------+------+----------+-------+
    | id | select_type | table | partitions | type | possible_keys | key  | key_len | ref  | rows | filtered | Extra |
    +----+-------------+-------+------------+------+---------------+------+---------+------+------+----------+-------+
    |  1 | SIMPLE      | user  | NULL       | ALL  | NULL          | NULL | NULL    | NULL |    1 |   100.00 | NULL  |
    +----+-------------+-------+------------+------+---------------+------+---------+------+------+----------+-------+
    注：
    type （最好到最差）
        const   一般是主键或唯一索引的查找
        eq_reg  索引范围查找     
        ref     索引查找
        range   范围查找
        index   索引扫描
        All     表扫描
        
    possible_keys 没有可用的索引
    key     等于NULL，说明未用到索引 
    key_len 索引长度，在不损失精确性的情况下，越短越好。
    ref     显示那一列索引被使用，一个常数是最好的。
    rows    必须检查的用来返回请求数据的行数
    Extra   
        using filesort  存在排序问题
        using temporary 存在临时表或不同列集合进行排序

      运算函数查询 
        max(i) count(i)     i建覆盖索引，通过索引可直接返回统计数
        
      子查询
      排序查询
      分页查询

    C.如何选择建立索引
    C1.在where, group by, order by, on从句中出现的列，或select中出现的列
    C2.索引字段越小越好
    C3.散度大的列（可count来统计，越大散度越大），放到联合索引的最前面
    
    D.索引维护
    重复索引    
        比如：主键索引又建了一个唯一索引
    冗余索引    
        多个前缀列相同联合索引
    工具检查    
        pt-duplicate-key-checker -root -p -h 127.0.0.1 会帮你查出需要优化的索引
    维护方法(删除不使用索引) 
        persondb和mariadb中可通过INDEX_STAISTICS表查出，
        mysql可使用分析工具 pt-index-usage -root -p mysql-slow.log 
        注意主从数据库，主不用不代表从不用。
    
    E.表优化
        选择合适的类型
            使用存储最小的数据类型
            使用简单的数据类型，int比varchar处理简单
            尽可能使用not null定义字段，或给定默认值
            尽量少用text类型和bit类型，非用不可，可考虑分表
            比如：IP地址可用bigint 可用对应函数转换：INET_ATON(EXPR)，INET_NTOA（EXPR）
         
         范式优化
            第三范式：
                要求数据表中不存在非关键字段对任意候选关键字段的传递函数依赖
                如：商品名称=》商品分类=》分类描述
                
            反范式
                适当的增加冗余，拿空间换时间
                如：用户=》订单
                
            垂直拆分（宽）
                把不常用的字段放到一个表中
                把大字段独立放到一个表中
                把经常一起使用的字段放到一起
                
           水平筛分（量）
                数据量过大，拆分表每个结构一样
                对id进行hash运算，mod(id,5)分解
                针对不同的hashID把数据库分到不同表中
                
                跨分区表进行数据查询
                统计及后台报表操作
                
        F.网络配置优化
            网络配置    /etc/sysctl.conf
                tcp队列
                    net.ipv4.tcp_max_syn_backlog=65535
                减少断开连接时，资源回收
                    net.ipv4.tcp_max_tw_buckets=8000
                    net.ipv4.tcp_tw_reuse=1
                    net.ipv4.tcp_tw_recycle=1
                    net.ipv4.tcp_fin_timeout=10
            打开文件数 /etc/security/limits.conf
                soft nofile 65535
                hard nofile 65535
            关闭selinux 防火墙,减小性能损耗
            
        G.配置文件
            连接池 推荐总内存的80%
            innodb_buffer_pool_size
            缓存池 分成多份
            innodb_buffer_pool_instances
            innodb_log_buffer_size
            IO效率影响很大，默认1，可取0，1，2 ；建议2；安全要求高建议设置1；
            innodb_lush_log_at_trx_commit
            读写的io进程
            innodb_read_io_threads
            innodb_write_io_threads
            共享表空间 默认off
            innodb_file_per_table
            刷新表统计信息
            innodb_stats_on_metadata
            
         第三方工具   
            https://tools.percona.com 引导式设置配置文件
            
         硬件优化
            选择CPU
            
            disk io
                RAID0   条带
                RAID1   镜像
                RAID5   逻辑盘
                SNA
                NAT
                SSD
                
            
        
    
    
    
    

