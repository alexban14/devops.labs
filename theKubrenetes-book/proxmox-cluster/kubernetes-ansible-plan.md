# Kubernetes Cluster Provisioning Plan with Ansible

This document outlines the plan to provision a 3-node control plane and 2-node worker Kubernetes cluster on your 5 Debian VMs using Ansible.

## 1. Prerequisites

1.  **Ansible Installed**: Ensure you have Ansible installed on the machine you will run the commands from.
2.  **SSH Access**: You must have passwordless SSH access (using SSH keys) from your control machine to all 5 Debian VMs as the `root` user.
3.  **Update Inventory**: Before running the playbook, you **must** edit the `inventory.ini` file and replace the placeholder IP addresses (`mgr1-ip`, `mgr2-ip`, etc.) with the actual IP addresses of your VMs.

## 2. File Structure

Here are the files that have been created for this process:

```
.
├── ansible.cfg
├── inventory.ini
├── kubernetes-ansible-plan.md
├── playbooks
│   ├── 01-prerequisites.yml
│   ├── 02-kube-install.yml
│   ├── 03-control-plane.yml
│   └── 04-workers.yml
└── setup-cluster.yml
```

## 3. Execution

Once the prerequisites are met and the inventory is updated, you can provision the entire cluster with a single command:

```bash
ansible-playbook setup-cluster.yml
```

The playbook will:
1.  Configure prerequisites (disable swap, install dependencies, set kernel parameters) on all nodes.
2.  Install `containerd` as the container runtime on all nodes.
3.  Install Kubernetes components (`kubeadm`, `kubelet`, `kubectl`) on all nodes.
4.  Initialize the control plane on the first manager (`ddd-swrm-mgr1`).
5.  Install Calico as the CNI (Container Network Interface) for pod networking.
6.  Join the other two control plane nodes.
7.  Join the two worker nodes.

## 4. Post-Installation

After the playbook successfully completes:

1.  SSH into your primary control plane node (`ddd-swrm-mgr1`).
2.  Verify the cluster status:
    ```bash
    kubectl get nodes -o wide
    ```
    You should see all 5 nodes in the `Ready` state.
3.  Your `kubectl` is configured for the `root` user on `ddd-swrm-mgr1`. You can copy the `/root/.kube/config` file to your local machine to manage the cluster remotely.
