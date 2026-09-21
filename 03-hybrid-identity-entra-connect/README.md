# 03 — Hybrid Identity (Microsoft Entra Connect)

Kết nối Active Directory on-premises với Microsoft Entra ID (Azure AD) qua Entra Connect, thiết lập Seamless SSO để user đăng nhập cloud service bằng chính tài khoản domain on-prem.

## Nội dung triển khai

| Ảnh | Nội dung |
|---|---|
| [01-aadconnect-wizard-summary](./screenshots/01-aadconnect-wizard-summary.png) | Tóm tắt cấu hình sau khi chạy Entra Connect wizard |
| [02-aadconnect-sync-status](./screenshots/02-aadconnect-sync-status.png) | Trạng thái đồng bộ (sync) của Entra Connect |
| [03-entra-users-source](./screenshots/03-entra-users-source.png) | User trên Entra ID hiển thị nguồn gốc "Windows Server AD" |
| [04-entra-connect-health](./screenshots/04-entra-connect-health.png) | Microsoft Entra Connect Health — giám sát tình trạng đồng bộ |
| [05-seamless-sso-computer](./screenshots/05-seamless-sso-computer.png) | Computer object phục vụ Seamless SSO trong AD |
| [06-signin-test-office](./screenshots/06-signin-test-office.png) | Test đăng nhập Office/M365 bằng tài khoản đồng bộ từ on-prem |
| [07-dsregcmd-status](./screenshots/07-dsregcmd-status.png) | Trạng thái đăng ký thiết bị hybrid-join (`dsregcmd /status`) |

## Kỹ năng thể hiện
Microsoft Entra Connect (Azure AD Connect), directory synchronization, Seamless Single Sign-On (SSO), hybrid Azure AD join, Entra Connect Health monitoring.
