# 05 — Azure Enterprise Hybrid Lab

Thiết kế và triển khai hạ tầng Azure theo mô hình hub-spoke doanh nghiệp, mở rộng quản trị sang on-premises qua Azure Arc, có giám sát/sao lưu/vá lỗi vận hành đầy đủ, và Infrastructure as Code (Bicep) để tái triển khai.

> Module này là 1 lab **độc lập**, chạy trên subscription/tenant riêng, không liên quan kỹ thuật tới các module 01-04, 06 trong repo.

## Kiến trúc tổng thể

```
                    ┌──────────────────────────┐
                    │   vnet-hub-prod-jap        │
                    │   Bastion · VPN Gateway     │
                    └─────────────┬──────────────┘
                          peering │ peering
                 ┌────────────────┴────────────────┐
                 ▼                                  ▼
        ┌─────────────────┐               ┌─────────────────┐
        │ vnet-spoke-prod   │               │ vnet-spoke-dev   │
        │  VM + Storage      │               │  VM               │
        └─────────────────┘               └─────────────────┘

        ┌──────────────────────────────────────────────┐
        │  On-premises Domain Controller (Azure Arc)     │
        │  → cùng Log Analytics workspace + Update Manager│
        └──────────────────────────────────────────────┘
```

## Các phase triển khai

| Phase | Nội dung | Doc chi tiết |
|---|---|---|
| 1 | Governance Foundation — Management Groups, RBAC, Policy, Resource Lock, Budget | [docs/01-identity-governance.md](./docs/01-identity-governance.md) |
| 2 | Networking — Hub-Spoke VNet, NSG/ASG, Bastion, VPN, Network Watcher | [docs/02-networking.md](./docs/02-networking.md) |
| 3 | Compute & Storage — VM, Key Vault, Azure Files, Azure File Sync | [docs/03-compute-storage.md](./docs/03-compute-storage.md) |
| 4 | Hybrid Management — Azure Arc onboarding on-prem DC | [docs/04-hybrid-migration.md](./docs/04-hybrid-migration.md) |
| 5 | Monitoring, Backup & Operations — Log Analytics, Alerts, Backup, Update Manager | [docs/05-monitoring-backup-ops.md](./docs/05-monitoring-backup-ops.md) |

## Infrastructure as Code

Thư mục [`infra/`](./infra) chứa code Bicep để tái triển khai hạ tầng (network hub + monitoring/backup/alert), được viết dựa trên chính cấu hình thật đã export từ subscription (qua `aztfexport`), không phải viết theo trí nhớ.

```
infra/
├── main.bicep                    # orchestrator, deploy scope Subscription
├── modules/
│   ├── network-hub.bicep         # VNet hub, Bastion, NSG, Peering
│   └── monitoring.bicep          # Log Analytics, Action Group, Alerts, Backup Vault, Update Manager
└── parameters/
    └── prod.parameters.json
```

### Deploy

```bash
az login
az account set --subscription <subscription-id>

az deployment sub create \
  --location japaneast \
  --template-file infra/main.bicep \
  --parameters infra/parameters/prod.parameters.json
```

**Trước khi deploy, cần xác nhận/điều chỉnh các tham số sau trong `prod.parameters.json`:**
- `maintenanceRecurEvery` — lịch patch tự động (đang đặt `1Week Monday`)
- `activityLogAlertScopeResourceGroup` — resource group được theo dõi sự kiện Deallocate VM
- `maintenanceStartDateTime` — phải là thời điểm **tương lai** tại lúc deploy
- `spokeDevVnetId` / `spokeProdVnetId` / `vmProdResourceId` — Resource ID thật sau khi VM/VNet spoke đã tồn tại (để trống nếu module network chưa deploy xong)

**Giới hạn đã biết:** Azure Arc-enabled server (Domain Controller on-prem) không nằm trong phạm vi Bicep này — cần onboard thủ công bằng script agent riêng cho từng tenant (xem [docs/04-hybrid-migration.md](./docs/04-hybrid-migration.md)).

## Kỹ năng thể hiện

Hub-spoke network architecture, Azure Bastion, NSG/ASG, Point-to-Site VPN, Azure Arc-enabled servers, Azure Monitor & Log Analytics (KQL), Azure Backup, Azure Update Manager, RBAC & Governance, **Infrastructure as Code (Bicep)**, network troubleshooting (Effective Routes, Effective Security Rules, IP Flow Verify).
