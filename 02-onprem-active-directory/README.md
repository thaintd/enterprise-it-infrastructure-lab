# 02 — On-Premises Active Directory

Xây dựng và quản trị hạ tầng Active Directory truyền thống: cài đặt AD DS, tổ chức OU, Group Policy, DNS nội bộ, và File Server với phân quyền NTFS.

## Nội dung triển khai

| Ảnh | Nội dung |
|---|---|
| [01-server-manager-roles](./screenshots/01-server-manager-roles.png) | Cài đặt server roles (AD DS, DNS...) qua Server Manager |
| [02-aduc-ou-tree](./screenshots/02-aduc-ou-tree.png) | Cấu trúc Organizational Unit (OU) trong Active Directory Users and Computers |
| [03-users-list-it-ou](./screenshots/03-users-list-it-ou.png) | Danh sách user trong OU IT |
| [04-groups-list](./screenshots/04-groups-list.png) | Danh sách security group |
| [05-group-members-example](./screenshots/05-group-members-example.png) | Thành viên của 1 group cụ thể |
| [06-dns-manager-zones](./screenshots/06-dns-manager-zones.png) | Các zone DNS được quản lý qua DNS Manager |
| [07-dns-forward-records](./screenshots/07-dns-forward-records.png) | Bản ghi DNS forward (A/CNAME...) |
| [08-gpmc-gpo-list](./screenshots/08-gpmc-gpo-list.png) | Danh sách Group Policy Object (GPO) qua GPMC |
| [09-gpo-mapdrive-settings](./screenshots/09-gpo-mapdrive-settings.png) | Cấu hình GPO map network drive |
| [10-gpresult-client01](./screenshots/10-gpresult-client01.png) | Kết quả áp dụng GPO trên máy client (`gpresult`) |
| [11-fileserver-shares](./screenshots/11-fileserver-shares.png) | Danh sách share trên File Server |
| [12-fileserver-ntfs-permissions](./screenshots/12-fileserver-ntfs-permissions.png) | Phân quyền NTFS trên thư mục chia sẻ |
| [13-computers-adusc](./screenshots/13-computers-adusc.png) | Danh sách máy tính join domain (ADUC) |
| [14-dcdiag-result](./screenshots/14-dcdiag-result.png) | Kết quả kiểm tra sức khỏe Domain Controller (`dcdiag`) |
| [15-network-adapter-config](./screenshots/15-network-adapter-config.png) | Cấu hình network adapter cho Domain Controller |

## Kỹ năng thể hiện
Active Directory Domain Services (AD DS), Organizational Unit design, Group Policy Object (GPO), DNS Server, File Server & NTFS permissions, domain join, server health diagnostics (`dcdiag`, `gpresult`).
