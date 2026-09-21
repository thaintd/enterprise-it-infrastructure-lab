# 04 — Security & Compliance

Triển khai các lớp bảo mật và tuân thủ trên Microsoft 365: Conditional Access, quản lý thiết bị qua Intune, phát hiện mối đe dọa qua Defender, và bảo vệ dữ liệu qua Purview DLP.

## Nội dung triển khai

### Conditional Access
| Ảnh | Nội dung |
|---|---|
| [01-ca-policy-list](./screenshots/01-ca-policy-list.png) | Danh sách Conditional Access policy |
| [02-ca-policy-detail](./screenshots/02-ca-policy-detail.png) | Chi tiết cấu hình 1 policy (điều kiện, kiểm soát truy cập) |
| [03-breakglass-account-excluded](./screenshots/03-breakglass-account-excluded.png) | Tài khoản break-glass được loại trừ khỏi policy — đúng best practice tránh tự khóa quyền truy cập admin |
| [04-signin-logs](./screenshots/04-signin-logs.png) | Sign-in logs ghi nhận việc áp dụng Conditional Access |

### Microsoft Intune
| Ảnh | Nội dung |
|---|---|
| [05-intune-device-compliance](./screenshots/05-intune-device-compliance.png) | Trạng thái compliance của thiết bị quản lý |
| [06-intune-compliance-policy](./screenshots/06-intune-compliance-policy.png) | Cấu hình compliance policy |
| [07-intune-config-profile](./screenshots/07-intune-config-profile.png) | Configuration profile áp dụng cho thiết bị |

### Microsoft Defender & Purview
| Ảnh | Nội dung |
|---|---|
| [08-defender-alerts](./screenshots/08-defender-alerts.png) | Cảnh báo bảo mật từ Microsoft Defender |
| [09-purview-sensitivity-labels](./screenshots/09-purview-sensitivity-labels.png) | Sensitivity label trong Microsoft Purview |
| [10-purview-dlp-policy](./screenshots/10-purview-dlp-policy.png) | Cấu hình Data Loss Prevention (DLP) policy |
| [11-dlp-test-blocked-email](./screenshots/11-dlp-test-blocked-email.png) | Kết quả test thực tế — email chứa dữ liệu nhạy cảm bị DLP chặn |

## Kỹ năng thể hiện
Conditional Access (Zero Trust access control), break-glass account strategy, Microsoft Intune (MDM/compliance policy), Microsoft Defender (threat alerts), Microsoft Purview (sensitivity labels, DLP policy), security testing & validation.
